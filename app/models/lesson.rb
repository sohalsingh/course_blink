class Lesson < ApplicationRecord
  belongs_to :course

  has_one_attached :photo
  has_one_attached :pdf
  has_one_attached :video

  has_one :quiz

  def viewed_lesson?(user)
    return false if user.nil?
    LessonHistory.where(lesson_id: self.id, enrollment_id: user.enrollments.pluck(:id)).present?
  end

  def photo_url
    if self.photo.attached?
      Rails.application.routes.url_helpers.rails_blob_path(self.photo, only_path: true)
    else
      nil
    end
  end
end
