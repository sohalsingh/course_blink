class Quiz < ApplicationRecord
  belongs_to :course
  has_many :questions, dependent: :destroy

  validates :title, presence: true


  def attempted_by? user
    questions.each do |question|
      return false if !question.submitted_by? user
    end

    return true
  end

  def correct_answers user
    correct_answers = 0

    # find with submission.is_correct

    questions.each do |question|
      correct_answers += 1 if question.submissions.find_by(user: user).is_correct
    end

    return correct_answers
  end
end
