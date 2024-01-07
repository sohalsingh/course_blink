class Course < ApplicationRecord
  has_many :enrollments
  has_many :users, through: :enrollments
  has_many :lessons

  has_one_attached :photo
  has_one_attached :pdf
  has_one_attached :video

  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"


  def photo_url
    if self.photo.attached?
      Rails.application.routes.url_helpers.rails_blob_path(self.photo, only_path: true)
    else
      nil
    end
  end
end
