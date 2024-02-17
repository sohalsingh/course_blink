class CourseImpression < ApplicationRecord
  belongs_to :course
  belongs_to :user
end
