class Option < ApplicationRecord
  belongs_to :question

  def correct?
    question.answer.option_id == id
  end
end
