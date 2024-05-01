class UserController < ApplicationController
  include Authentication
  before_action :redirect_if_not_authenticated

  def api_profile
    render json: current_user, status: :ok
  end
end
