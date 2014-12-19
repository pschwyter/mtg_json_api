class Everything < ActiveRecord::Migration
  def change
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

	  add_index :cards, :card_set_id

	  create_table "cards_colors", force: true do |t|
	    t.integer "color_id"
	    t.integer "card_id"
	  end

	  add_index :cards_colors, :color_id
	  add_index :cards_colors, :card_id


	  create_table "subtypes", force: true do |t|
	    t.string "name"
	  end

	  create_table "cards_subtypes", force: true do |t|
	    t.integer "card_id"
	    t.integer "subtype_id"
	  end

	  add_index :cards_subtypes, :card_id
	  add_index :cards_subtypes, :subtype_id

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
	    t.integer  "amount",             default: 1
	    t.integer  "receiver_cards_id"
	    t.integer  "initiator_cards_id"
	  end

	  add_index :listed_cards, :user_id
	  add_index :listed_cards, :card_id

	  create_table "trades", force: true do |t|
	    t.datetime "created_at"
	    t.datetime "updated_at"
	    t.integer  "initiator_id"
	    t.integer  "receiver_id"
	    t.integer  "cards_from_receiver",  default: [],        array: true
	    t.integer  "cards_from_initiator", default: [],        array: true
	    t.boolean  "initiator_accepted",   default: false
	    t.boolean  "receiver_accepted",    default: false
	    t.string   "status",               default: "pending"
	  end

  	  add_index :trades, :initiator_id
	  add_index :trades, :receiver_id

	  create_table "lists", force: true do |t|
	  	t.integer "user_id"
	  	t.timestamps
	  end

	  add_index :lists, :user_id

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

	    t.integer "tradeable_list_id"
	    t.integer "inventory_list_id"
	    t.integer "wanted_list_id"
	  end

	  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  end
end
