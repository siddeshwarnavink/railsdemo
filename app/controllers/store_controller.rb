class StoreController < ApplicationController
  def index
    @rockets = Rocket.all
  end

  def api_index
    @rockets = Rocket.all
    render json: @rockets.map { |rocket| rocket.api_mapping }
  end
end
