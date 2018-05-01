# 股票列表
get '/api/stocks' do
  content_type :json
  stocks = Stock.all
  data = stocks.map do |stock|
    {
      name: stock.name,
      code: stock.code,
      avatar: stock.avatar
    }
  end
  {
    count: stocks.count,
    data: data
  }.to_json
end

# 股票详情
get '/api/stock/:code' do
  content_type :json
  stock = Stock.find(params[:code])
  {
    name: stock.name,
    code: stock.code,
    avatar: stock.avatar
  }.to_json
end

# 挂单列表
get '/api/stock/:code/order' do
  content_type :json
  stock = Stock.find(params[:code])
  orders = StockOrder.where(stock: stock, status: 'padding').order(id: :desc)
  data = orders.limit(10).map do |order|
    {
      id: order.id,
      user: {
        id: order.user.id,
        name: order.user.name
      },
      price: order.price,
      amount: order.amount,
      detail: order.detail,
      created_at: order.created_at.rfc2822
    }
  end
  {
    count: orders.count,
    data: data
  }.to_json
end

# 我的持股
get '/api/stock/:code/my' do
  content_type :json
  return { error: true, error_code: 401, msg: '未登录' }.to_json unless current_user
  stock = Stock.find(params[:code])
  {
    balance: current_user.stock_balance(stock)
  }.to_json
end

# 应援动态
get '/api/stock/:code/love' do
  content_type :json
  stock = Stock.find(params[:code])
  StockTransaction
    .where(stock: stock, pay_type: 'love')
    .order(id: :desc)
    .limit(10)
    .map do |transaction|
    {
      id: transaction.id,
      user: {
        id: transaction.payee.id,
        name: transaction.payee.name
      },
      amount: transaction.amount,
      detail: transaction.detail,
      created_at: transaction.created_at.rfc2822
    }
  end.to_json
end

# 应援
# {
#   "love_power": "1223243535",
#   "cheer_word": "我永远喜欢英梨梨",
# }
post '/api/stock/:code/love' do
  content_type :json
  return { error: true, error_code: 401, msg: '未登录' }.to_json unless current_user
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
