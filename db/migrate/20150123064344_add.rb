class Add < ActiveRecord::Migration
  def change
  	add_column :comments, :viewed, :boolean, :default => false
  end
end
