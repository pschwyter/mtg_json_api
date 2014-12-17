class ChangeTradeKeysToListedCards < ActiveRecord::Migration
  def change
  	remove_column :listed_cards, :initiator_cards_id, :integer
  	remove_column :listed_cards, :receiver_cards_id, :integer
  	add_column :listed_cards, :trade_by_initiator_id, :integer
  	add_column :listed_cards, :trade_by_receiver_id, :integer
  end
end
