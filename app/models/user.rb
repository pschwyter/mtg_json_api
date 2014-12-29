class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode
  after_save :initialize_lists
  
  has_many :initiated_trades, class_name: 'Trade', :foreign_key => 'initiator_id'
  has_many :received_trades, class_name: 'Trade', :foreign_key => 'receiver_id'

  LISTS = [:tradeable_list, :inventory_list, :wanted_list]
    
  LISTS.each do |list_name|
    belongs_to list_name, class_name: "List"
  end

  accepts_nested_attributes_for :tradeable_list, :wanted_list, :inventory_list

  def initialize_lists
    # p initializing: self
    LISTS.each do |list_name|
      unless send(list_name)
        update_attribute("#{list_name}_id", List.create(user: self, name: list_name).id)
      end
    end
  end

  def tradeable_cards
    self.tradeable_list.listed_cards
  end

  def check_for_tradeable_card(id)
    true if self.tradeable_list.listed_cards.find_by(card_id: id)
  end

  def wanted_cards
    self.wanted_list.listed_cards
  end

  def inventory_cards
    self.inventory_list.listed_cards
  end

  def check_for_wanted_card(id)
    true if self.wanted_list.listed_cards.find_by(card_id: id)
  end

end


