class CardsController < ApplicationController

  def show

  end

  def index

    if params[:card_fields] #params[:card_fields]
      search_params
      query = Card.all

      unless params[:card_fields][:name].blank?
        query = query.where(name: Regexp.new(params[:card_fields][:name], 'i'))
      end
      unless params[:card_fields][:type].blank?
        query = query.where(type: Regexp.new(params[:card_fields][:type], 'i'))
      end
      unless params[:card_fields][:subtypes].blank?
        query = query.where(subtypes: Regexp.new(params[:card_fields][:subtypes], 'i'))
      end
      # unless params[:card_fields][:cmc].blank?
      #   query = query.where(cmc: Regexp.new(params[:card_fields][:cmc], 'i'))
      # end
      @cards = query
      # binding.pry
    else
      @cards = Card.where(name: "Black Lotus")
    end

  end

  private

  def search_params
    params.require(:card_fields).permit(:name, :type, :subtypes, :cmc)
  end

end
