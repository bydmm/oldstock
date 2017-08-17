require 'sinatra'
require './config/settings'

get '/' do
  'Hello world!'
end

get '/check' do
  data = {
    a: 1,
    b: 2
  }
  data.to_json
end
