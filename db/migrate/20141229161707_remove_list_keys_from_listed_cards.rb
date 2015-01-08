class RemoveListKeysFromListedCards < ActiveRecord::Migration
  def change
  	remove_column :listed_cards, :tradeable_list_id, :integer
  	remove_column :listed_cards, :wanted_list_id, :integer
  	remove_column :listed_cards, :inventory_list_id, :integer
  end
end
