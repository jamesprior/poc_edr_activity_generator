require 'test_helper'

class EdrActivityGeneratorTest < Minitest::Test
  def test_empty_filename
    logger = Logger.new(StringIO.new)
    edr_generator = EdrActivityGenerator.new(config_filename: '', logger: logger)
    assert_equal [], edr_generator.operations
  end

  def test_non_file
    logger = Logger.new(StringIO.new)
    edr_generator = EdrActivityGenerator.new(config_filename: 'test/', logger: logger)
    assert_equal [], edr_generator.operations
  end

  def test_invalid_yaml
    logger = Logger.new(StringIO.new)
    edr_generator = EdrActivityGenerator.new(config_filename: File.expand_path(__FILE__), logger: logger)
    assert_equal [], edr_generator.operations
  end
end