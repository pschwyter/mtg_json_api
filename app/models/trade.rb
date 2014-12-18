class Trade < ActiveRecord::Base
	belongs_to :initiator, class_name: 'User'
	belongs_to :receiver, class_name: 'User'

	before_save :replace_nil_with_array

	def accept(user)
		if self.initiator == user
			self.initiator_accepted = true
		elsif self.receiver == user
			self.receiver_accepted = true
		end
	end

	def other_user(current_user)
		if self.initiator == current_user
			@@other_user = self.receiver
			self.receiver
		elsif self.receiver == current_user
			@@other_user = self.initiator
			self.initiator
		end
	end

	private

	def replace_nil_with_array
		if self.cards_from_initiator == nil
			self.cards_from_initiator = []
		end
		if self.cards_from_receiver == nil
			self.cards_from_receiver = []
		end
	end
end
