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
  if current_user
    {
      user_id: current_user.id,
      name: current_user.name,
      token: current_user.token
    }.to_json
  else
    {
      error: true,
      error_code: 401,
      msg: '未登录'
    }.to_json
  end
end
