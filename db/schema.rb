# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150123013739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_sets", force: true do |t|
    t.string   "booster",       array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "code"
    t.string   "gatherer_code"
    t.string   "release_date"
    t.string   "border"
    t.string   "set_type"
    t.string   "block"
  end

  create_table "card_types", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "card_types_cards", force: true do |t|
    t.integer "card_type_id"
    t.integer "card_id"
  end

  create_table "cards", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "layout"
    t.integer  "multiverseid"
    t.string   "name"
    t.integer  "cmc"
    t.string   "rarity"
    t.string   "artist"
    t.string   "power"
    t.string   "toughness"
    t.string   "mana_cost"
    t.text     "text"
    t.text     "flavor"
    t.string   "image_name"
    t.integer  "card_set_id"
    t.integer  "price",        default: 0
  end

  add_index "cards", ["card_set_id"], name: "index_cards_on_card_set_id", using: :btree

  create_table "cards_colors", force: true do |t|
    t.integer "card_id"
    t.integer "color_id"
  end

  create_table "cards_subtypes", force: true do |t|
    t.integer "card_id"
    t.integer "subtype_id"
  end

  add_index "cards_subtypes", ["card_id"], name: "index_cards_subtypes_on_card_id", using: :btree
  add_index "cards_subtypes", ["subtype_id"], name: "index_cards_subtypes_on_subtype_id", using: :btree

  create_table "colors", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "comments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "trade_id"
    t.text     "body"
  end

  add_index "comments", ["trade_id"], name: "index_comments_on_trade_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "listed_cards", force: true do |t|
    t.integer  "card_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amount",        default: 1
    t.integer  "list_id"
    t.integer  "active_trades", default: [], array: true
  end

  add_index "listed_cards", ["card_id"], name: "index_listed_cards_on_card_id", using: :btree

  create_table "lists", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "lists", ["user_id"], name: "index_lists_on_user_id", using: :btree

  create_table "subtypes", force: true do |t|
    t.string "name"
  end

  create_table "trades", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "initiator_id"
    t.integer  "receiver_id"
    t.integer  "cards_from_receiver",     default: [],        array: true
    t.integer  "cards_from_initiator",    default: [],        array: true
    t.boolean  "initiator_accepted",      default: false
    t.boolean  "receiver_accepted",       default: false
    t.string   "status",                  default: "pending"
    t.integer  "qty_from_initiator",      default: [],        array: true
    t.integer  "qty_from_receiver",       default: [],        array: true
    t.integer  "card_ids_from_initiator", default: [],        array: true
    t.integer  "card_ids_from_receiver",  default: [],        array: true
    t.boolean  "initiator_viewed",        default: false
    t.boolean  "receiver_viewed",         default: false
    t.string   "last_edit_by"
  end

  add_index "trades", ["initiator_id"], name: "index_trades_on_initiator_id", using: :btree
  add_index "trades", ["receiver_id"], name: "index_trades_on_receiver_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "dci_number"
    t.string   "crypted_password",                null: false
    t.string   "salt",                            null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "email",                           null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "location"
    t.integer  "tradeable_list_id"
    t.integer  "inventory_list_id"
    t.integer  "wanted_list_id"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end
