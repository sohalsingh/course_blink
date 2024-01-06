class Course < ApplicationRecord
  has_many :enrollments
  has_many :users, through: :enrollments
  has_many :lessons

  has_one_attached :photo
  has_one_attached :pdf
  has_one_attached :video
end
