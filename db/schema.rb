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

ActiveRecord::Schema.define(version: 20141214024834) do

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
    t.string   "card_types",   array: true
    t.string   "sub_types",    array: true
    t.string   "colors",       array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "layout"
    t.string   "card_type"
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

  create_table "subtypes", force: true do |t|
    t.string "name"
  end

end
