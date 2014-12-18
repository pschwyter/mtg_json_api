class RemoveUserIdFromListedCards < ActiveRecord::Migration
  def change
  	remove_column :listed_cards, :user_id, :integer
  end
end
