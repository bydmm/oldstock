require File.expand_path '../test_helper.rb', __FILE__

class HelloWorldTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_says_hello_world
    get '/api/user'
    assert last_response.ok?
    assert_equal 'Hello World', last_response.body
  end
end
