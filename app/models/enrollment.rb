class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  has_many :lesson_histories, dependent: :destroy
end
