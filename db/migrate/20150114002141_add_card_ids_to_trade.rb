class AddCardIdsToTrade < ActiveRecord::Migration
  def change
  	add_column :trades, :card_ids_from_initiator, :integer, array: true, default: []
  	add_column :trades, :card_ids_from_receiver, :integer, array: true, default: []
  end
end
