
class StockTransaction < ActiveRecord::Base
  belongs_to :payer, class_name: 'User', foreign_key: :payer
  belongs_to :payee, class_name: 'User', foreign_key: :payee_id
  belongs_to :stock

  enum pay_type: %i[love trade]

  after_save :change_user_stock

  private

  def change_user_stock
    if amount >= 0
      UserStock.add(payee, stock, amount)
    else
      UserStock.minus(payee, stock, amount)
    end
  end
end
