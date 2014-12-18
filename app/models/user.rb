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

  LISTS = [:tradeable_list, :inventory_list, :wanted_list]
    
  LISTS.each do |list_name|
    belongs_to list_name, class_name: "List"
  end

  before_save :initialize_lists

  def initialize_lists
    LISTS.each do |list_name|
      unless send(list_name)
        self.send("#{list_name}=", List.create(user: self))
      end
    end
  end

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

  def before_save

  end

end


