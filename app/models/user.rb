class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  
  has_many :listed_cards
  has_many :initiated_trades, class_name: 'Trade', :foreign_key => 'initiator_id'
  has_many :received_trades, class_name: 'Trade', :foreign_key => 'receiver_id'

  def tradeable_cards
    self.listed_cards.where(status: 1)
  end

  def get_tradeable_card(id)
    self.listed_cards.where(status: 1).where(card_id: id).first
  end

  def wanted_cards
    self.listed_cards.where(status: 0)
  end

  def get_wanted_card(id)
    self.listed_cards.where(status: 0).where(card_id: id).first
  end

end


