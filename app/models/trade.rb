class Trade < ActiveRecord::Base
	belongs_to :initiator, class_name: 'User'
	belongs_to :receiver, class_name: 'User'
end
