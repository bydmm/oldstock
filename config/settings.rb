configure do
  # set :server, :puma
end

configure :development do
  set :foo, 'bar'
end

configure :production do

end
