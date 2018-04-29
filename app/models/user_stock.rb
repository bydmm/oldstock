class UserStock < ActiveRecord::Base
  belongs_to :user
  belongs_to :stock

  def self.find_and_create(other_user, other_stock)
    UserStock.where(user: other_user, stock: other_stock).first_or_create
  end

  def self.add(other_user, other_stock, amount)
    UserStock.find_and_create(other_user, other_stock)
    UserStock
      .where(user: other_user, stock: other_stock)
      .update_all("balance = balance + #{amount}")
  end

  def self.minus(other_user, other_stock, amount)
    UserStock.find_and_create(other_user, other_stock)
    UserStock
      .where(user: other_user, stock: other_stock)
      .update_all("balance = balance - #{amount}")
  end
end
