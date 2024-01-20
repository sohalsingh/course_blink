class Lesson < ApplicationRecord
  belongs_to :course

  has_one_attached :photo
  has_one_attached :pdf
  has_one_attached :video


  def photo_url
    if self.photo.attached?
      Rails.application.routes.url_helpers.rails_blob_path(self.photo, only_path: true)
    else
      nil
    end
  end
end
