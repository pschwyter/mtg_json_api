class ListedCard < ActiveRecord::Base
	belongs_to :card
	belongs_to :user 

	STATUS_NAMES = {0 => "Wanted", 1 => "Tradeable", 2 => "Inventory"}

	def status
		STATUS_NAMES[attributes["status"]]
	end

	def add_one
		self.amount += 1
		self.save!
	end

	def remove_one
		if self.amount > 1
			self.amount -= 1
			self.save
		else
			self.destroy
		end
	end
end

