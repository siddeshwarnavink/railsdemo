module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :current_user
    helper_method :current_user
    helper_method :user_signed_in?
  end

  def login(user)
    reset_session
    session[:current_user_id] = user.id
  end

  def logout
    reset_session
  end

  def redirect_if_authenticated
    redirect_to root_path, alert: "You are already logged in." if user_signed_in?
  end

  def redirect_if_not_authenticated
    if user_signed_in?
    elsif request.path.starts_with?("/api/")
      unless current_user.present?
        render json: { error: "You need to login before continuing" }, status: :unauthorized
      end
    else
      redirect_to login_path, alert: "You need to login before continuing" unless user_signed_in?
    end
  end

  def user_signed_in?
    session[:current_user_id].present?
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @current_user = User.find_by(id: user_id)
    else
      @current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
    end
  end

  private

  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_SECRET'])
  end

  def decoded_token
    header = request.headers['Authorization']
    if header
      token = header.split(" ")[1]
      begin
        JWT.decode(token, ENV['JWT_SECRET'])
      rescue JWT::DecodeError
        nil
      end
    end
  end

end
