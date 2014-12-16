class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude 
  
  has_many :listed_cards
  has_many :initiated_trades, class_name: 'Trade', :foreign_key => 'initiator_id'
  has_many :received_trades, class_name: 'Trade', :foreign_key => 'receiver_id'

  def tradeable_cards
    self.listed_cards.where(status: 1)
  end

  def wanted_cards
    self.listed_cards.where(status: 0)
  end
end


