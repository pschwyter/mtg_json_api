class CardsController < ApplicationController

  def show

  end

  def index

    if params[:card_fields]
      @cards = search
    else
      @cards = Card.where(name: "Black Lotus")
    end


  end

  def search
    search_params
    sanitized_search = search_params.delete_if { |k,v| v.blank? }
    query = Card.all
    sanitized_search.each do |key, value|

      if key == "name"
        query = query.where(["#{key} iLIKE ?", "%#{value}%"])
      end
      
      if key == "cmc"
        num = value.to_i
        cmcmod = sanitized_search[:cmcmod]
        query = query.where("#{key} #{cmcmod} ?", num)
      end

      if key == "card_type"
        card_type_query = CardType.where(["name iLIKE ?", "%#{value}%"]).first.cards
        query = [query, card_type_query].inject(&:&)
      end

      if key == "subtypes"
        values = value.gsub(/\s+/, "").split(",")
        subtype_query = []
        values.each do |subtype|
          subtype_query = Subtype.where(["name iLIKE ?", "%#{subtype}%"]).first.cards
          query = [query, subtype_query].inject(&:&)
        end
      end

      if key == "white" && value == "1"
        color_query = Color.where(name: "White").first.cards
        query = [query, color_query].inject(&:&)
      end

      if key == "blue" && value == "1"
        color_query = Color.where(name: "Blue").first.cards
        query = [query, color_query].inject(&:&)
      end

      if key == "black" && value == "1"
        color_query = Color.where(name: "Black").first.cards
        query = [query, color_query].inject(&:&)
      end

      if key == "red" && value == "1"
        color_query = Color.where(name: "Red").first.cards
        query = [query, color_query].inject(&:&)
      end

      if key == "green" && value == "1"
        color_query = Color.where(name: "Green").first.cards
        query = [query, color_query].inject(&:&)
      end

    end

    query
  end

  private

  def search_params
    params.require(:card_fields).permit(:name, :cmc, :card_type, :subtypes, :cmcmod, :subtypes, :artist, :red, :black, :blue, :green, :white)
  end

end





