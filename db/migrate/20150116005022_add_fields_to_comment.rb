class AddFieldsToComment < ActiveRecord::Migration
  def change
  	add_reference :comments, :user, :index => true
  	add_reference :comments, :trade, :index => true

  	add_column :comments, :body, :text
  end
end
