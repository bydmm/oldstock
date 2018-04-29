class CoinTransaction < ActiveRecord::Base
  belongs_to :payer, class_name: 'User', foreign_key: :payer
  belongs_to :payee, class_name: 'User', foreign_key: :payee_id
end
