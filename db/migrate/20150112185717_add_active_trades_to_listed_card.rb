class AddActiveTradesToListedCard < ActiveRecord::Migration
  def change
  	add_column :listed_cards, :active_trades, :integer, default: [], array: true
  end
end
