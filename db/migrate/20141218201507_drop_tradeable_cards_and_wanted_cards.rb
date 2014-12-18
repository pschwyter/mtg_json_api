class DropTradeableCardsAndWantedCards < ActiveRecord::Migration
  def change
  	drop_table :tradeable_cards
  	drop_table :wanted_cards
  end
end
