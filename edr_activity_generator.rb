# Root file for the library, pressed into double duty as a loader and class-definer
lib_path = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

require 'json'
require 'yaml'
require 'logger'
require 'socket'
require 'lib/event'
require 'lib/operation/process_start'
require 'lib/operation/create_file'
require 'lib/operation/delete_file'
require 'lib/operation/modify_file'
require 'lib/operation/network_request'
require 'lib/os'
if OS.windows?
  require 'lib/operation/windows/network_request'
end


# Runner class
class EdrActivityGenerator
  attr_reader :logger, :config_filename, :operations, :events
  VALID_OPERATIONS = %w[CreateFile DeleteFile ModifyFile NetworkRequest ProcessStart].freeze

  def initialize(config_filename:, logger: nil)
    @config_filename = config_filename
    @logger = logger || default_logger
    @operations = load_operations
    @events = []
  end

  def load_operations
    logger.debug("validating config filename: #{config_filename}")
    if config_filename.nil? || config_filename.empty?
      logger.error("config filename is blank")
      return []
    end

    full_path = File.expand_path(config_filename)
    if ! File.file?(full_path)
      logger.error("config is not a file")
      return []
    end

    begin
      YAML.load_file(full_path).collect do |operation|
        operation.transform_keys!(&:to_sym)
      end
    rescue StandardError => e
      logger.error("could not load config yaml: #{e.message}")
      []
    end
  end

  def execute!
    operations.each do |operation|
      next unless valid_operation?(operation)

      begin
        logger.debug("Invoking operation #{operation.inspect}")
        @events << Operation.const_get(operation[:type]).new(operation).invoke
      rescue StandardError => e
        logger.error("Could not complete operation #{operation.inspect}: #{e.message}")
        logger.debug(e.backtrace.join("\n"))
      end
    end
  end

  protected
  def valid_operation?(operation)
    unless VALID_OPERATIONS.include?(operation[:type])
      logger.warn("Operation #{operation.inspect} it is not one of #{VALID_OPERATIONS.inspect}")
      return false
    end

    true
  end

  def default_logger
    default_logger = Logger.new(STDOUT)
    default_logger.level = Logger::DEBUG
    default_logger
  end
end
