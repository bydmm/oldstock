class User < ActiveRecord::Base
  has_secure_password

  validates :name, uniqueness: true, presence: true
  validates :password, presence: true, length: { in: 6..20 }
  validates :password_confirmation, presence: true

  before_create :generate_token

  def generate_token
    self.token = String.random
  end

  def love(stock, detail)
    StockTransaction.create(
      payer_id: 0,
      payee_id: id,
      stock: stock,
      pay_type: 'love',
      amount: love_amount,
      detail: detail
    )
  end

  def balance
    UserWallet.find_or_create_by(user: self).balance
  end

  def stock_balance(stock)
    UserStock.find_and_create(self, stock).balance
  end

  private

  def love_amount
    case rand(1..100)
    when 100
      233
    else
      rand(1..5)
    end
  end
end
