ENV['RACK_ENV'] = 'test'
require 'test/unit'
require 'rack/test'

require File.expand_path '../../app.rb', __FILE__
require File.expand_path '../order_test.rb', __FILE__
