class AddSubTypesToCards < ActiveRecord::Migration
  def change
  	add_column :cards, :sub_types, :array
  end
end
