class Lesson < ApplicationRecord
  belongs_to :course

  has_one_attached :photo
  has_one_attached :pdf
  has_one_attached :video
end
