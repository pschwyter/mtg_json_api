class AddNameToList < ActiveRecord::Migration
  def change
  	add_column :lists, :name, :string
  end
end
