class AddEditStatusAndViewStatusToTrades < ActiveRecord::Migration
  def change
  	add_column :trades, :initiator_viewed, :boolean, default: false
  	add_column :trades, :receiver_viewed, :boolean, default: false
  	add_column :trades, :last_edit_by, :string
  end
end
