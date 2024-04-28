class User < ApplicationRecord
  has_secure_password

  validates :email, presence: {message: "Provide a Email"}, uniqueness: {message: "Already registered"}
  validates :password, presence: { message: "Provide a Password" }

  CONFIMATION_TOKEN_EXPIRATION = 10.minutes

  before_save :downcase_email

  def confirm!
    update_columns(confirmed_at: Time.current)
  end

  def confirm?
    confirmed_at.present?
  end

  def unconfirmed?
    !confirmed?
  end

  def generate_confirmation_token
    signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_email
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
