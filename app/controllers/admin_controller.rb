class
AdminController < ApplicationController
  include Authentication
  before_action :redirect_if_not_authenticated

  def create
    @rocket = Rocket.new
  end

  def post_create()
    @rocket = Rocket.new(form_params)
    if @rocket.save
      redirect_to root_path, notice: "Rocket was successfully created."
    else
      flash.now[:alert] = "Rocket creation failed."
      render :create
    end
  end

  def edit
    @rocket = Rocket.find(params[:id])
  end

  def post_edit
    @rocket = Rocket.find(params[:id])
    if @rocket.update(form_params)
      redirect_to root_path, notice: "Product updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete
    @rocket = Rocket.find(params[:id])
    @rocket.delete
    redirect_to root_path, notice: "Product deleted successfully."
  end

  private

  def form_params
    params.require(:rocket).permit(:Name, :Price, :description, :Image)
  end
end
