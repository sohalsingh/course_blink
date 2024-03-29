class User < ApplicationRecord

  # roles
  enum role: [:user, :teacher, :admin]

  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
  has_many :submissions, dependent: :destroy
  has_many :course_impressions, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def gravatar
    if self.gravatar_url.nil?
      self.update(gravatar_url: "https://gravatar.com/avatar/#{Digest::SHA2.hexdigest self.email}?d=retro")
    end
    return self.gravatar_url
  end

  def enrolled_in? course
    return self.enrollments.where(course: course).any?
  end

end
