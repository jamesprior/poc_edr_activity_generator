
lib_path = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

require 'json'
require 'lib/event'
