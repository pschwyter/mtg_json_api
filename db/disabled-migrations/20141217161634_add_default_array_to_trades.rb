class AddDefaultArrayToTrades < ActiveRecord::Migration
  def up
  	change_column :trades, :cards_from_initiator, :integer, array: true, default: []
  	change_column :trades, :cards_from_receiver, :integer, array: true, default: []
  end

  def down
  	change_column :trades, :cards_from_initiator, :integer, array: true
  	change_column :trades, :cards_from_receiver, :integer, array: true
  end
end
