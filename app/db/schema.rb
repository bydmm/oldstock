# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180429060842) do

  create_table "coin_transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "payer"
    t.integer "payee"
    t.integer "stock_id"
    t.integer "pay_type"
    t.integer "amount"
    t.index ["pay_type"], name: "index_coin_transactions_on_pay_type"
    t.index ["payee"], name: "index_coin_transactions_on_payee"
    t.index ["payer"], name: "index_coin_transactions_on_payer"
  end

  create_table "stock_transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "payer"
    t.integer "payee"
    t.integer "stock_id"
    t.integer "pay_type"
    t.integer "amount"
    t.index ["pay_type"], name: "index_stock_transactions_on_pay_type"
    t.index ["payee"], name: "index_stock_transactions_on_payee"
    t.index ["payer"], name: "index_stock_transactions_on_payer"
    t.index ["stock_id"], name: "index_stock_transactions_on_stock_id"
  end

  create_table "stocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "code"
    t.text "avatar"
    t.index ["code"], name: "index_stocks_on_code"
  end

  create_table "user_stocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "stock_id"
    t.integer "amount"
    t.index ["stock_id"], name: "index_user_stocks_on_stock_id"
    t.index ["user_id"], name: "index_user_stocks_on_user_id"
  end

  create_table "user_wallets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "amount"
    t.index ["user_id"], name: "index_user_wallets_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "password_digest"
    t.string "token"
    t.index ["token"], name: "index_users_on_token"
  end

end
