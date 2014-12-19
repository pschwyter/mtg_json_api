class CreateListedCards < ActiveRecord::Migration
  def change
    create_table :listed_cards do |t|
 	  t.belongs_to :user
 	  t.belongs_to :card
 	  t.column :status, :integer
 	  
      t.timestamps
    end
  end
end
