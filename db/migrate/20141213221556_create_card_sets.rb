class CreateCardSets < ActiveRecord::Migration
  def change
    create_table :card_sets do |t|

      t.timestamps
    end
  end
end
