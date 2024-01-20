class Question < ApplicationRecord
  belongs_to :quiz
  has_many :options, dependent: :destroy
  has_many :submissions, dependent: :destroy
  has_one :answer, dependent: :destroy

  accepts_nested_attributes_for :options, allow_destroy: true


  validates :title, presence: true


  def submitted_by? user
    return false if user.nil?

    return false if user.submissions.where(question: self).empty?

    return true
  end
end
