#!/usr/bin/env ruby
# Usage:
#
# $ ruby generate.rb config-file.yml

require 'rubygems'
require 'bundler/setup'
require './edr_activity_generator'

logger = Logger.new(STDOUT)
logger.level = Logger::DEBUG

config_filename = ARGV[0]

activity_generator = EdrActivityGenerator.new(config_filename: config_filename, logger: logger)

activity_generator.execute!

# TODO:  see if we can get event slimmed down in what it emits, maybe on a per-type basis.
# TODO make some base classes?
# TODO file creation

# Questions
# gotta be process owner name, or could it be uid?
# how much polish
# how many tests?
# what do we mean by 'file type' - could it be part of the path?
# yo are we sure about all this because it seems like a lot for 4-6 hours