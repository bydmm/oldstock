require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require './config/settings'
require './models/user'
require './models/game_archive'
require 'pry' if development?

get '/test/hello' do
  content_type :json
  '{}'
end

# /account/bilibili_login/
# ?from=bilibili&game_id=250&gid=654&login=1&login_ip=127_0_0_1
# &login_time=1502080146362&server_id=422
# &sign=f0f940c0ad73cf9ea17a7899cd43bdef&timestamp=1502080146362
# &token=7701303
# &uid=7701343
# &uname=hello
# &test=1

get '/bilibili_login/' do
  content_type :json
  puts params
  @user = User.find_by(token: params[:token])
  if @user.blank?
    @user = User.create(
      token: params[:token],
      uname: params[:uname],
      from: params[:from]
    )
  end
  {
    ipad_token: @user.ipad_token,
    android_token: @user.android_token,
    apple_token: @user.apple_token,
  }.to_json
end

# {
#   "channel_token":"1b6fe627a0b34370364c4909b0437f28d59d2d45", 
#   "client_type":2,
# }
post "/ngame/:id/archive/" do
  content_type :json
  payload = JSON.parse(request.body.read)
  user = User.find_by_channel_token(payload['client_type'], payload['channel_token'])
  return { error: 'Access forbidden' }.to_json if user.blank?
  @archive = GameArchive.find_by(game_id: params[:id], user_id: user.id)
  if @archive.blank?
    @archive = GameArchive.create(
      game_id: params[:id],
      user_id: user.id,
      from: user.from,
      content: '{}'
    )
  end
  {
    channel_token: payload['channel_token'],
    client_type: payload['channel_token'],
    content: @archive.content,
  }.to_json
end

# {
#   "channel_token":"1b6fe627a0b34370364c4909b0437f28d59d2d45", 
#   "client_type":2,
#   "content": "1234" # 存档内容
# }
put "/ngame/:id/archive/" do
  content_type :json
  payload = JSON.parse(request.body.read)
  user = User.find_by_channel_token(payload['client_type'], payload['channel_token'])
  return { error: 'Access forbidden' }.to_json if user.blank?
  @archive = GameArchive.find_or_create_by(game_id: params[:id], user_id: user.id)
  @archive.content = payload['content']
  @archive.save
  {
    channel_token: payload['channel_token'],
    client_type: payload['client_type'],
    content: @archive.content
  }.to_json
end
