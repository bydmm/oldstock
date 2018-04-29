class User < ActiveRecord::Base
  has_secure_password

  validates :name, uniqueness: true, presence: true
  validates :password, presence: true, length: { in: 6..20 }
  validates :password_confirmation, presence: true

  before_create :generate_token

  def generate_token
    self.token = String.random
  end

  def love(stock)
    StockTransaction.create(
      payer_id: 0,
      payee_id: id,
      stock_id: stock.id,
      pay_type: 'love',
      amount: rand(1..5)
    )
  end
end
