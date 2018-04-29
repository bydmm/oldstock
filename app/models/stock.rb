class Stock < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  validates :code, presence: true, length: { in: 2..20 }
  validates :avatar, uniqueness: true
end
