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

ActiveRecord::Schema.define(version: 20141216221921) do

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
  end

  create_table "cards_colors", force: true do |t|
    t.integer "color_id"
    t.integer "card_id"
  end

  create_table "cards_subtypes", force: true do |t|
    t.integer "card_id"
    t.integer "subtype_id"
  end

  create_table "colors", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "listed_cards", force: true do |t|
    t.integer  "user_id"
    t.integer  "card_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "initiator_cards_id"
    t.integer  "receiver_cards_id"
  end

  create_table "subtypes", force: true do |t|
    t.string "name"
  end

  create_table "trades", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "start_initiator_list", array: true
    t.string   "start_receiver_list",  array: true
    t.string   "end_initiator_list",   array: true
    t.string   "end_receiver_list",    array: true
    t.integer  "initiator_id"
    t.integer  "receiver_id"
  end

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
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end
