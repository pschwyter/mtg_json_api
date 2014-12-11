class CardsController < ApplicationController

  @@json_card_data = File.read('vendor/assets/jsondata/AllSets.json')
  

  def show

  end

  def index
    @cards_hash = ActiveSupport::JSON.decode(@@json_card_data)

    if search_params
      # @cards_to_display = @cards_hash['LEA']['cards'].select {|card| card['name'] == search_params[:name] }
    else
      @cards_to_display = @cards_hash['LEA']['cards']
    end

  end

  def create
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 

  def search_params
    # params.require(:card_fields).permit(:name)
  end

end
