class AddSetIdToCards < ActiveRecord::Migration
  def change
  	add_column :cards, :card_set_id, :integer
  end
end
