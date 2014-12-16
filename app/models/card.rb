class Card < ActiveRecord::Base
	belongs_to :card_set
	has_and_belongs_to_many :colors
	has_and_belongs_to_many :card_types
	has_and_belongs_to_many :subtypes

	has_many :list_cards

end
