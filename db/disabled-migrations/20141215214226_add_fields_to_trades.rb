class AddFieldsToTrades < ActiveRecord::Migration
  def change
  	add_column :trades, :start_initiator_list, :string, array: true
  	add_column :trades, :start_receiver_list, :string, array: true
  	add_column :trades, :end_initiator_list, :string, array: true
  	add_column :trades, :end_receiver_list, :string, array: true
  end
end
