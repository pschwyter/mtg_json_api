class AddFieldsToCardSets < ActiveRecord::Migration
  def change
  	add_column :card_sets, :name, :string
  	add_column :card_sets, :code, :string
    add_column :card_sets, :gatherer_code, :string
    add_column :card_sets, :release_date, :string
    add_column :card_sets, :border, :string
    add_column :card_sets, :set_type, :string
    add_column :card_sets, :booster, :array
  end
end
