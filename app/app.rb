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

set :protection, except: :json_csrf

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
post '/api/users' do
  content_type :json
  payload = JSON.parse(request.body.read)
  user = User.new(name: payload['name'], password: payload['password'], password_confirmation: payload['password_confirmation'])
  if user.save
    {
      user_id: user.id,
      name: user.name,
      token: user.token
    }.to_json
  else
    {
      error: true,
      msg: user.errors.full_messages.join(', ')
    }.to_json
  end
end

# 登录
# {
#   "user": "bydmm",
#   "password": "123456",
# }
post '/api/users/login' do
  content_type :json
  payload = JSON.parse(request.body.read)
  user = User.find_by(name: payload['name']).try(:authenticate, payload['password'])
  if user
    {
      user_id: user.id,
      name: user.name,
      token: user.token
    }.to_json
  else
    {
      error: true,
      msg: '账户或者密码错误'
    }.to_json
  end
end

# 获取用户
# header "x-token": "435345435345",
get '/api/user' do
  content_type :json
  token = request.env['HTTP_X_TOKEN']
  user = User.find_by(token: token)
  if user
    {
      user_id: user.id,
      name: user.name,
      token: user.token
    }.to_json
  else
    {
      error: true,
      msg: '未登录'
    }.to_json
  end
end
