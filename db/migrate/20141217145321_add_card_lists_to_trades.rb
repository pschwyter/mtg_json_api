class AddCardListsToTrades < ActiveRecord::Migration
  def change
  	add_column :trades, :cards_from_initiator, :integer, array: true
  	add_column :trades, :cards_from_receiver, :integer, array: true
  end
end
