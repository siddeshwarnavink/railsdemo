class Rocket < ApplicationRecord
  has_rich_text :description
  has_one_attached :image, dependent: :destroy

  after_destroy_commit :purge_image_variants

  validates :Name, presence: { message: 'Provide a valid name' }
  validates :Price, presence: { message: 'Provide a valid price' }, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: { message: 'Provide a valid description' }
  validates :image, presence: { message: 'Provide a valid thumbnail' }
  validates :launch_at, presence: { message: 'Provide a valid launch date' }

  def api_mapping
    attributes.symbolize_keys.merge(
      description: description.to_plain_text,
      thumbnail_url:
    )
  end

  def image_as_thumbnail
    image.variant(resize_to_limit: [500, 500]).processed
  end

  private

  def purge_image_variants
    image.variant_records.each(&:destroy)
    image.purge_later
  end

  def thumbnail_url
    return unless image.attached?

    Rails.application.routes.url_helpers.rails_representation_url(image_as_thumbnail, only_path: true)
  end
end
