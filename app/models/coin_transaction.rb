class CoinTransaction < ActiveRecord::Base
  belongs_to :payer, class_name: 'User', foreign_key: :payer
  belongs_to :payee, class_name: 'User', foreign_key: :payee_id

  enum pay_type: %i[check_in trade]

  after_save :change_user_wallet

  private

  def change_user_wallet
    if amount >= 0
      UserWallet.add(payee, stock, amount)
    else
      UserWallet.minus(payee, stock, amount)
    end
  end
end
