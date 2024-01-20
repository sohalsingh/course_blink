class LessonHistory < ApplicationRecord
  belongs_to :lesson
  belongs_to :enrollment
end
