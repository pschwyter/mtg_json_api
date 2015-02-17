require 'rails_helper'

RSpec.describe User, :type => :model do

  describe "creating a new user" do
  	
  	it "doesn't save if the user is created without a password or password_confirmation" do
  		# setup
  		user = User.new(
  			email: 'email@email.com'	
			)

  		# exercise
  		result = user

  		# verify
  		expect(result.save).to be false
  	end

  	it 'initializes three card lists once created' do 
  		# setup
  		user = User.create(
				email: 'email@email.com', 
			  password: '1234', 
				password_confirmation: '1234'
			)
  		# exercise
  		result1 = user.tradeable_list
  		result2 = user.wanted_list
  		result3 = user.inventory_list

  		# verify
  		expect(result1.name).to eq 'tradeable_list'
  		expect(result2.name).to eq 'wanted_list'
  		expect(result3.name).to eq 'inventory_list'
  	end
  end

end