class AuthController < ApplicationController
  include Authentication
  before_action :redirect_if_authenticated, only: [:get_login, :post_login]

  def get_login
    @user = User.new
  end

  def post_login
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user.present? && @user.authenticate(params[:user][:password])
      login @user
      redirect_to root_path, notice: "Signed in."
    else
      flash.now[:alert] = "Incorrect email or password."
      @user ||= User.new
      render :get_login, status: :unprocessable_entity
    end
  end

  def post_logout
    logout
    redirect_to root_path, notice: "Signed out."
  end

  def get_signup
    @user = User.new
  end

  def post_signup
    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation))
    if @user.save
      redirect_to login_path, notice: "Account created! Please login now"
    else
      render :get_signup, status: :unprocessable_entity
    end
  end

  def api_login
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user.present? && @user.authenticate(params[:user][:password])
      @token = encode_token(user_id: @user.id)
      render json: {
        user: UserSerializer.new(@user),
        token: @token
      }, status: :ok
    else
      render json: { message: "Incorrect email or password." }, status: :bad_request
    end
  end
end
