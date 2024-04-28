class StoreController < ApplicationController
  def index
    @rockets = Rocket.all
  end
end
