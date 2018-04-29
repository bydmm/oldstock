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
  stock = Stock.find_by(code: params[:code])
  {
    name: stock.name,
    code: stock.code,
    avatar: stock.avatar
  }.to_json
end

# 应援
post '/api/stock/:code/love' do
  content_type :json
  return { error: true, error_code: 443, msg: '未登录' }.to_json unless current_user
  stock = Stock.find_by(code: params[:code])
  transaction = current_user.love(stock)
  if transaction.errors
    { success: true, msg: "抽到了#{transaction.amount}股，恭喜" }
  else
    { success: false, msg: '没抽到，再接再厉' }
  end.to_json
end
