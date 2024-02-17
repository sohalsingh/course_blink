class Course < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:title, :description]

  # also search on associated lessons
  pg_search_scope :search_by_title_and_description, against: [:title, :description],
    associated_against: {
      lessons: [:title, :description]
    }
    

  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments
  has_many :lessons, dependent: :destroy
  has_many :quizzes, dependent: :destroy
  has_many :course_impressions, dependent: :destroy

  has_one_attached :photo
  has_one_attached :pdf
  has_one_attached :video

  attr_accessor :remove_photo
  attr_accessor :remove_pdf
  attr_accessor :remove_video

  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"

  def all_lessons_viewed?(user)
    return false if user.nil?
    self.lessons.each do |lesson|
      return false if !lesson.viewed_lesson?(user)
    end
    true
  end

  def all_quizzes_attempted?(user)
    return false if user.nil?
    self.quizzes.each do |quiz|
      return false if !quiz.attempted_by?(user)
    end
    true
  end

  def completed_by?(user)
    return false if user.nil?
    return false if !self.all_lessons_viewed?(user)
    return false if !self.all_quizzes_attempted?(user)
    true
  end

  def photo_url
    if self.photo.attached?
      Rails.application.routes.url_helpers.rails_blob_path(self.photo, only_path: true)
    else
      nil
    end
  end

  # To get most viewed courses
  def self.most_viewed(query=nil, limit = 100)
    # Get filtered courses or all courses
    filtered_courses = query.present? ? search_by_title_and_description(query).ids : Course.ids
  
    # Get most viewed courses
    Course.where(id: filtered_courses)
          .joins(:course_impressions)
          .select('courses.*, COUNT(course_impressions.id) AS views_count')
          .group('courses.id')
          .order('views_count DESC')
          .limit(limit)
  end
end
