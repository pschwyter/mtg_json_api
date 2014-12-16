class ListedCard < ActiveRecord::Base
	belongs_to :card
	belongs_to :user
	belongs_to :trade
	# ListedCard and Trade should be HABTM?

	def add_one
		self.amount += 1
	end

	def remove_one
		if self.amount > 1
			self.amount -= 1
		else
			self.destroy
		end
	end
end

