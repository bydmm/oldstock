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

ActiveRecord::Schema.define(version: 20170823012003) do

  create_table "game_archives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "game_id"
    t.string "from"
    t.string "user_id"
    t.text "content"
    t.index ["from"], name: "index_game_archives_on_from"
    t.index ["game_id", "user_id"], name: "index_game_archives_on_game_id_and_user_id"
    t.index ["game_id"], name: "index_game_archives_on_game_id"
    t.index ["user_id"], name: "index_game_archives_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "from"
    t.string "token"
    t.string "uname"
    t.string "ipad_token"
    t.string "android_token"
    t.string "apple_token"
    t.index ["android_token"], name: "index_users_on_android_token"
    t.index ["apple_token"], name: "index_users_on_apple_token"
    t.index ["ipad_token"], name: "index_users_on_ipad_token"
    t.index ["token"], name: "index_users_on_token"
  end

end
