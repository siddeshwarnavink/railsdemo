class Rocket < ApplicationRecord
  validates :Name, presence: {message: "Provide a valid name"}
  validates :Price, presence: {message: "Provide a valid price"}, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: {message: "Provide a valid description"}
  validates :Image, presence: {message: "Provide a Image link"}
end
