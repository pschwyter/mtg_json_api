class AddDefaultAmountToListedCard < ActiveRecord::Migration
  def change
  	change_column :listed_cards, :amount, :integer, :default => 1
  end
end
