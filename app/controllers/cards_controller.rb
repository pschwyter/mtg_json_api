class CardsController < ApplicationController

  def show

  end

  def index

    if params[:card_fields]
      @cards = search
    else

    end

  end

  def search
    search_params
    sanitized_search = search_params.delete_if { |k,v| v.blank? }
    query = Card.all

    sanitized_search.each do |key, value|
      puts "#{key}: #{value}"
      
      if key == "cmc"
        num = value.to_i
        operator = sanitized_search[:cmcmod]
        if operator = "="
          comparison_query = num
        else
          comparison_query = {"$#{mod}" => num}
        end
        query = query.where("cmc" => comparison_query)

      elsif key == "cmcmod"
        query = query

      elsif key == "subtypes"
        query =  Card.where("subtypes" => {"$in" => [/#{value}/i]})

      else
        query = query.where(key => /#{value}/i)

      end
      # binding.pry

    end
    query

  end

  private

  def search_params
    params.require(:card_fields).permit(:name, :type, :subtypes, :cmc, :cmcmod, :subtypes, :artist)
  end

end
