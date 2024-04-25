class HelloController < ApplicationController
  def index
    @rockets = Rocket.all
  end
end
