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
  stock = Stock.find_by(code: params[:code])
  current_user.love(stock)
end
