
class StockTransaction < ActiveRecord::Base
  belongs_to :payer, class_name: 'User', foreign_key: :payer
  belongs_to :payee, class_name: 'User', foreign_key: :payee_id
  belongs_to :stock

  enum pay_type: %i[love trade]

  after_save :change_user_stock

  private

  def change_user_stock
    user_stock = UserStock.find_or_create_by(user: payee, stock: stock)
    user_stock.update_attribute(balance: user_stock.balance + amount)
  end
end
