class AddKeysToTrade < ActiveRecord::Migration
  def change
  	change_table :trades do |t|
    	t.integer :initiator_id
    	t.integer :receiver_id
    end
  end
end
