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

# 应援动态
get '/api/stock/:code/love' do
  content_type :json
  stock = Stock.find_by(params[:code])
  StockTransaction
    .where(stock: stock, pay_type: 'love')
    .order(id: :desc)
    .limit(10)
    .map do |transaction|
    {
      user: {
        name: transaction.payee.name
      },
      amount: transaction.amount,
      created_at: transaction.created_at.to_i
    }
  end
end

# 应援
post '/api/stock/:code/love' do
  content_type :json
  return { error: true, error_code: 443, msg: '未登录' }.to_json unless current_user
  payload = JSON.parse(request.body.read)
  unless love?(params[:code], payload['love_power'], 4)
    return { success: false, msg: '应援失败，再接再厉！' }.to_json
  end
  stock = Stock.find(params[:code])
  transaction = current_user.love(stock)
  if transaction.errors
    { success: true, msg: "应援成功，抽到了#{transaction.amount}股！" }
  else
    { success: false, msg: '服务器傲娇了' }
  end.to_json
end
