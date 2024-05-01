class UserController < ApplicationController
  before_action :authorized
  def api_profile
    render json: current_user, status: :ok
  end
end
