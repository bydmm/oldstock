# 交易
# {
#   "code": "ERIRI",
#   "amount": 100,
#   "price": 3.00,
# }
post '/api/order' do
  content_type :json
  return { error: true, error_code: 401, msg: '未登录' }.to_json unless current_user
  payload = json_parse(request.body.read)
  order_form = OrderForm.new(payload, current_user)
  unless order_form.valid?
    return {
      error: true,
      msg: order_form.errors.full_messages.join(', ')
    }.to_json
  end
  if order_form.submit
    {
      success: true,
      msg: '挂单成功'
    }.to_json
  else
    {
      error: true,
      msg: order_form.order.errors.full_messages.join(', ')
    }.to_json
  end
end
