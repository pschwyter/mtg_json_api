class AddFieldsToCardTypes < ActiveRecord::Migration
  def change
  	add_column :card_types, :name, :string
  end
end
