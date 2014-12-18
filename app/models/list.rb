class List < ActiveRecord::Base
	has_many :listed_cards
	has_many :cards, through: :listed_cards
	belongs_to :user


	def add(card, amount)
		listed_cards.find_or_create_by(card: card)
	end

	def remove(card, amount)
	end

end