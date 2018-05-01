class StockOrder < ActiveRecord::Base
  enum status: %i[padding success cancel]

  serialize :detail, Hash

  belongs_to :stock, foreign_key: :stock_code
  belongs_to :user

  validates :stock, presence: true
  validates :user, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 100 }
  validates :amount, presence: true, numericality: { only_integer: true }

  validate :amount_lower_limit, :amount_not_zero,
           :enough_money, :enough_stock,
           :order_limit

  def order_limit
    if StockOrder.where(user: user, status: 'padding').count > 5
      errors.add(:base, :total_order_limit)
    end
    if StockOrder.where(user: user, status: 'padding', stock: stock).count > 2
      errors.add(:base, :single_order_limit)
    end
  end

  def amount_not_zero
    errors.add(:amount, :not_equal_zero) if amount.zero?
  end

  def amount_lower_limit
    errors.add(:amount, :amount_lower_limit) unless amount.abs >= 100
  end

  def enough_money
    errors.add(:base, :not_enough_blance) if amount > 0 && user.balance < (price * amount)
  end

  def enough_stock
    errors.add(:base, :not_enough_stock) if amount < 0 && user.stock_balance(stock) < amount.abs
  end
end
