class AddFlavorAndImageNameToCards < ActiveRecord::Migration
  def change
  	add_column :cards, :flavor, :string
  	add_column :cards, :image_name, :string
  end
end
