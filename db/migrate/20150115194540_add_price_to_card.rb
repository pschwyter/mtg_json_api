class AddPriceToCard < ActiveRecord::Migration
  def change
  	add_column :cards, :price, :integer, :default => 0
  end
end
