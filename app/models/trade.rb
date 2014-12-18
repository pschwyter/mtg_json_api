class Trade < ActiveRecord::Base
	belongs_to :initiator, class_name: 'User'
	belongs_to :receiver, class_name: 'User'

	before_save :replace_nil_with_array


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
