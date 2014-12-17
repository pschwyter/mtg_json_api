class RemoveCardsColumnFromTrades < ActiveRecord::Migration
  def change
  	remove_column :trades, :cards_from_initiator
  	remove_column :trades, :cards_from_receiver
  end
end
