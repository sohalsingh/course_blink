class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :option

  # user can't submit more than one answer for a question
  validates :user_id, uniqueness: { scope: :question_id }

  # user can't submit answer for a question that is not present in the quiz
  validate :validate_option

  # after creating a submission, check if the answer is correct
  after_create :update_is_correct

  def update_is_correct
    update(is_correct: option.correct?)
  end

  private

  def validate_option
    return if question.options.include?(option)

    errors.add(:option, "Must be present in question")
  end
end
