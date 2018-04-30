class StockOrder < ActiveRecord::Base
  serialize :detail, Hash

  belongs_to :stock, foreign_key: :stock_code
  belongs_to :user

  validates :stock, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 100 }
  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 100 }
end
