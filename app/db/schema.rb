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
    t.integer "payer_id"
    t.integer "payee_id"
    t.integer "pay_type"
    t.integer "amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pay_type"], name: "index_coin_transactions_on_pay_type"
    t.index ["payee_id"], name: "index_coin_transactions_on_payee_id"
    t.index ["payer_id"], name: "index_coin_transactions_on_payer_id"
  end

  create_table "stock_transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "payer_id"
    t.integer "payee_id"
    t.integer "stock_code"
    t.integer "pay_type"
    t.integer "amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pay_type"], name: "index_stock_transactions_on_pay_type"
    t.index ["payee_id"], name: "index_stock_transactions_on_payee_id"
    t.index ["payer_id"], name: "index_stock_transactions_on_payer_id"
    t.index ["stock_code"], name: "index_stock_transactions_on_stock_code"
  end

  create_table "stocks", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code", null: false
    t.string "name"
    t.text "avatar"
    t.index ["code"], name: "index_stocks_on_code", unique: true
  end

  create_table "user_stocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "stock_code"
    t.integer "balance", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "stock_code"], name: "index_user_stocks_on_user_id_and_stock_code", unique: true
  end

  create_table "user_wallets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "balance", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_wallets_on_user_id", unique: true
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "password_digest"
    t.string "token"
    t.index ["token"], name: "index_users_on_token", unique: true
  end

end
