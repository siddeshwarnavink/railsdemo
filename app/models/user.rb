class User < ApplicationRecord
  has_secure_password

  validates :email, presence: { message: "Provide a Email" }, uniqueness: { message: "Already registered" }
  validates :password, presence: { message: "Provide a Password" }

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end
