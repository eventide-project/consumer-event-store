ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= '_min'

puts RUBY_DESCRIPTION

require_relative '../init.rb'
require 'consumer/event_store/controls'

require 'test_bench'; TestBench.activate

require 'pp'

Controls = Consumer::EventStore::Controls
