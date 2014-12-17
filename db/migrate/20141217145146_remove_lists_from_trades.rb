class RemoveListsFromTrades < ActiveRecord::Migration
  def change
  	remove_column :trades, :start_initiator_list
  	remove_column :trades, :start_receiver_list
  	remove_column :trades, :end_initiator_list
  	remove_column :trades, :end_receiver_list
  end
end
