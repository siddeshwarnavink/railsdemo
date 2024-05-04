class AdminController < ApplicationController
  include Authentication
  before_action :redirect_if_not_authenticated

  def create
    @rocket = Rocket.new
  end

  def post_create
    @rocket = Rocket.new(form_params)
    if @rocket.save
      redirect_to root_path, notice: 'Rocket was successfully created.'
    else
      flash.now[:alert] = 'Rocket creation failed.'
      render :create
    end
  end

  def edit
    @rocket = Rocket.find(params[:id])
  end

  def post_edit
    @rocket = Rocket.find(params[:id])
    if @rocket.update(form_params)
      flash.now[:alert] = 'Product updated successfully.'
      respond_to do |format|
        format.turbo_stream do
          @rockets = Rocket.all
          render turbo_stream: [
            turbo_stream.replace("modal", '<turbo-frame id="modal"></turbo-frame>'),
            turbo_stream.replace("page", template: "store/index")
          ]
        end
        format.html { redirect_to root_path }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete
    @rocket = Rocket.find(params[:id])
    @rocket.destroy
    redirect_to root_path, notice: 'Product deleted successfully.'
  end

  def api_create
    @rocket = Rocket.new(form_params)

    if @rocket.save
      render json: @rocket.api_mapping, status: :created
    else
      render json: @rocket.errors, status: :unprocessable_entity
    end
  end

  private

  def form_params
    params.require(:rocket).permit(:Name, :Price, :description, :image, :launch_at)
  end
end
