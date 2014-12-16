class AddAmountToListedCard < ActiveRecord::Migration
  def change
  	add_column :listed_cards, :amount, :integer
  end
end
