class AddListKeysToListedCard < ActiveRecord::Migration
  def change
  	add_column :listed_cards, :tradeable_list_id, :integer
  	add_column :listed_cards, :wanted_list_id, :integer
  	add_column :listed_cards, :inventory_list_id, :integer
  end
end
