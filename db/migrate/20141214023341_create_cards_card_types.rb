class CreateCardsCardTypes < ActiveRecord::Migration
  def change
    create_table :card_types_cards do |t|
    	t.integer :card_type_id
    	t.integer :card_id
    end
  end
end
