require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require 'sinatra/cookies'
require 'i18n'
require 'i18n/backend/fallbacks'
require 'securerandom'
require './lib/random'
require './config/settings'
require './models/user'
require 'pry' if development?

get '/' do
  content_type :json
  {
    msg: 'Hello World!'
  }.to_json
end

# 注册
# {
#   "user": "bydmm",
#   "password": "123456",
#   "password_confirmation": "123456"
# }
post '/users' do
  content_type :json
  payload = JSON.parse(request.body.read)
  user = User.new(name: payload['name'], password: payload['password'], password_confirmation: payload['password_confirmation'])
  if user.save
    {
      user_id: user.id,
      token: user.token
    }.to_json
  else
    {
      error: true,
      msg: user.errors.full_messages
    }.to_json
  end
end

# 登录
# {
#   "user": "bydmm",
#   "password": "123456",
# }
post '/users/login' do
  content_type :json
  payload = JSON.parse(request.body.read)
  user = User.find_by(name: payload['name']).try(:authenticate, payload['password'])
  if user
    cookies[:token] = user.token
    {
      user_id: user.id,
      token: user.token
    }.to_json
  else
    {
      error: true,
      msg: '账户或者密码错误'
    }.to_json
  end
end
