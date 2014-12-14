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
    # binding.pry
    query = Card.all

    sanitized_search.each do |key, value|
      
      if key == "cmc"
        num = value.to_i
        cmc = case sanitized_search[:cmcmod]
          when "e" then :cmc
          when "gt" then :cmc.gt
          when "lt" then :cmc.lt
          when "gte" then :cmc.gte
          when "lte" then :cmc.lte
        end

        query = query.where(cmc => num)

      elsif key == "cmcmod"
        query = query

      elsif key == "subtypes"
        query =  query.where("'?' = ANY (subtypes)", value)

      else
        query = query.where(["#{key} iLIKE ?", "%#{value}%"])
      end

    end
    query
    # binding.pry
  end

  private

  def search_params
    params.require(:card_fields).permit(:name, :type, :subtypes, :cmc, :cmcmod, :subtypes, :artist)
  end

end
