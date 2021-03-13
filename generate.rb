#!/usr/bin/env ruby
# Usage:
#
# $ ruby generate.rb config-file.yml

require 'rubygems'
require 'bundler/setup'
require './edr_activity_generator'

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG

config_filename = ARGV[0]

activity_generator = EdrActivityGenerator.new(config_filename: config_filename, logger: logger)

activity_generator.execute!

puts activity_generator.events.to_json

# TODO:  see if we can get event slimmed down in what it emits, maybe on a per-type basis.
