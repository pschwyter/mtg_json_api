class AddKeysToListedCards < ActiveRecord::Migration
  def change
  	change_table :listed_cards do |t|
    	t.integer :initiator_cards_id
    	t.integer :receiver_cards_id
    end
  end
end
