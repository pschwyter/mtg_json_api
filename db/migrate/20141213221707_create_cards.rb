class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :card_types, array: true
	  t.string :sub_types, array: true
	  t.string :colors, array: true


      t.timestamps
    end
  end
end
