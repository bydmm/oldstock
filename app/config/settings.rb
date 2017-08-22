configure do
end

configure :development do

end

configure :production do
  set :server, :puma
end
