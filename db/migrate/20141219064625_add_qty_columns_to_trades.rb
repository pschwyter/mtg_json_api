class AddQtyColumnsToTrades < ActiveRecord::Migration
  def change
  	add_column :trades, :qty_from_initiator, :integer, array: true, default: []
  	add_column :trades, :qty_from_receiver, :integer, array: true, default: []
  end
end
