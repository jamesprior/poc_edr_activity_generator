#!/usr/bin/env ruby
# Usage:
#
# $ ruby generate.rb config-file.yml

require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'logger'

LOG_LEVEL = Logger::DEBUG

@logger = Logger.new(STDOUT)
@logger.level = LOG_LEVEL

config_filename = ARGV[0]

def valid_config_option(config_filename)
  @logger.debug("validating config filename: #{config_filename}")
  if config_filename.nil? || config_filename.empty?
    @logger.warn("config filename is blank")
    return false
  end

  full_path = File.expand_path(config_filename)
  if ! File.file?(full_path)
    @logger.warn("config is not a file")
    return false
  end

  contents = begin
    YAML.load_file(full_path)
  rescue StandardError => e
    @logger.warn("could not load config yaml: #{e.message}")
    false
  end

  @logger.debug("config file contents are #{contents.inspect}")
  return false unless contents

  true
end

abort("A configuration file is required, see config.example.yml for a sample") unless valid_config_option(config_filename)
