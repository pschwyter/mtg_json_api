class RemoveStatusFromListedCards < ActiveRecord::Migration
  def change
  	remove_column :listed_cards, :status, :integer
  end
end
