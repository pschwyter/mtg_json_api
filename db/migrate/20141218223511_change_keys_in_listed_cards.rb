class ChangeKeysInListedCards < ActiveRecord::Migration
  def change
  	remove_column :listed_cards, :receiver_cards_id, :integer
  	remove_column :listed_cards, :initiator_cards_id, :integer

	add_column :listed_cards, :list_id, :integer 	
  end
end
