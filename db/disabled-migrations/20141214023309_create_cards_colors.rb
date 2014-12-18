class CreateCardsColors < ActiveRecord::Migration
  def change
    create_table :cards_colors do |t|
    	t.integer :color_id
    	t.integer :card_id
    end
  end
end
