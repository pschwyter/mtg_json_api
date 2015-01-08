class ReorderCardsColorsJoinTable < ActiveRecord::Migration
  def change
  	remove_column :cards_colors, :color_id, :integer
  	remove_column :cards_colors, :card_id, :integer
  	add_column :cards_colors, :card_id, :integer
  	add_column :cards_colors, :color_id, :integer
  end
end
