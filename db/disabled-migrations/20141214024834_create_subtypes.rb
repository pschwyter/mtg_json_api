class CreateSubtypes < ActiveRecord::Migration
  def change
    create_table :subtypes do |t|
    	t.string :name
    end

    create_table :cards_subtypes do |t|
    	t.integer :card_id
    	t.integer :subtype_id
    end

  end
end
