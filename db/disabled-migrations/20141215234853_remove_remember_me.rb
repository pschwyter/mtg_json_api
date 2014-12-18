class RemoveRememberMe < ActiveRecord::Migration
  def change
  	remove_column :users, :remember_me_token, :string, :default => nil
    remove_column :users, :remember_me_token_expires_at, :datetime, :default => nil

  end
end
