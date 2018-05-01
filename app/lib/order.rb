class OrderForm
  include ActiveModel::Model

  attr_reader :user

  validates :code, presence: true
  validates :price, presence: true
  validates :amount, presence: true
  validate :stock_presence

  def initialize(other_payload, other_user)
    @payload = other_payload
    @user = other_user
  end

  def code
    @payload['code']
  end

  def stock
    @stock ||= Stock.find_by(code: code)
  end

  def price
    @payload['price']
  end

  def amount
    @payload['amount']
  end

  def detail
    @payload['detail']
  end

  def order
    @order ||= StockOrder.new(
      user: user,
      stock: stock,
      price: price,
      amount: amount,
      detail: detail,
      status: 'padding'
    )
  end

  def submit
    order.save
  end

  private

  def stock_presence
    errors.add(:code, :not_exist) unless stock
  end
end
