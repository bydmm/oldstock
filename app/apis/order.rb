# 交易
# {
#   "code": "ERIRI",
#   "action": "buy",
#   "amount": "100",
#   "price": 3.00,
# }
post '/api/order' do
  content_type :json
  return { error: true, error_code: 443, msg: '未登录' }.to_json unless current_user
  payload = JSON.parse(request.body.read)
  unless love?(params[:code], payload['cheer_word'], payload['love_power'], 4)
    return { success: false, msg: '应援失败，再接再厉！' }.to_json
  end
  stock = Stock.find(params[:code])
  transaction = current_user.love(stock, payload)
  if transaction.errors
    { success: true, msg: "应援成功，抽到了#{transaction.amount}股！" }
  else
    { success: false, msg: '服务器傲娇了' }
  end.to_json
end
