class CreateCardsCardTypes < ActiveRecord::Migration
  def change
    create_table :cards_card_types do |t|
    	t.integer :card_type_id
    	t.integer :card_id
    end
  end
end
