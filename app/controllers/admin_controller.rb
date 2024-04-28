class AdminController < ApplicationController
  include Authentication
  before_action :redirect_if_not_authenticated

  def create
    @rocket = Rocket.new
  end

  def post_create()
    @rocket = Rocket.new(params.require(:rocket).permit(:Name, :Price, :description, :Image))
    if @rocket.save
      redirect_to root_path, notice: "Rocket was successfully created."
    else
      flash.now[:alert] = "Rocket creation failed."
      render :create
    end
  end
end
