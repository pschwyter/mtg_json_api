class CreateCardSets < ActiveRecord::Migration
  def change
    create_table :card_sets do |t|
      t.string :booster, array: true

      t.timestamps
    end
  end
end
