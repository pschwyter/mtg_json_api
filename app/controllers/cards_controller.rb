class CardsController < ApplicationController

  def show

  end

  def index

    if search_params

    else
      @cards = Card.all
    end

  end

  private 

  def search_params

  end

end
