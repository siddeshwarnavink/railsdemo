class AdminController < ApplicationController
  def create()
    @rocket = Rocket.new(rocket_params)
    if @rocket.save
      redirect_to root_path, notice: "Rocket was successfully created."
    else
      flash.now[:alert] = "Rocket creation failed."
      render :index
    end
  end

  def index
    @rocket=Rocket.new
  end

  private

  def rocket_params
    params.require(:rocket).permit(:Name, :Price, :description, :Image)
  end
end
