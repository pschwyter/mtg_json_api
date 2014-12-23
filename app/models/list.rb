class List < ActiveRecord::Base
	has_many :listed_cards, :foreign_key => 'tradeable_list_id'
	has_many :listed_cards, :foreign_key => 'wanted_list_id'
	has_many :listed_cards, :foreign_key => 'inventory_list_id'
	has_many :cards, through: :listed_cards
	belongs_to :user

	accepts_nested_attributes_for :listed_cards

	def add(card, amount)
		listed_cards.find_or_create_by(card: card)
	end

	def remove(card, amount)
	end

end