class Answer < ApplicationRecord
  belongs_to :option
  belongs_to :question

  # options should be of options present in the question validation
  validate :validate_option

  def title
    option.title
  end

  private

  def validate_option
    return if question.options.include?(option)

    errors.add(:option, "Must be present in question")
  end
end
