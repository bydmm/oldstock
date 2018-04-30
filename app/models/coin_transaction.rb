class CoinTransaction < ActiveRecord::Base
  enum pay_type: %i[check_in trade]
  serialize :detail, Hash

  belongs_to :payer, class_name: 'User', foreign_key: :payer
  belongs_to :payee, class_name: 'User', foreign_key: :payee_id

  after_save :change_user_wallet

  private

  def change_user_wallet
    if amount >= 0
      UserWallet.add(payee, amount)
    else
      UserWallet.minus(payee, amount)
    end
  end
end
