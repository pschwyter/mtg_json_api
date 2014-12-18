class AddStatusToTrades < ActiveRecord::Migration
  def change
  	add_column :trades, :initiator_accepted, :boolean, default: false
  	add_column :trades, :receiver_accepted, :boolean, default: false
  	add_column :trades, :status, :string, default: "pending"
  end
end