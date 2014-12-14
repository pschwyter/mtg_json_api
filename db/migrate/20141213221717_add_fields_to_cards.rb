class AddFieldsToCards < ActiveRecord::Migration
  def change
  	add_column :cards, :layout, :string
  	add_column :cards, :card_type, :string
  	add_column :cards, :multiverseid, :integer
  	add_column :cards, :name, :string
  	add_column :cards, :cmc, :integer
  	add_column :cards, :rarity, :string
  	add_column :cards, :artist, :string
  	add_column :cards, :power, :string
  	add_column :cards, :toughness, :string
  	add_column :cards, :mana_cost, :string
  	add_column :cards, :text, :text
  end
end
