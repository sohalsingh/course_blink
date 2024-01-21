class Option < ApplicationRecord
  belongs_to :question
  has_one :answer, dependent: :destroy
  has_many :submissions, dependent: :destroy

  def correct?
    question.answer.option_id == id
  end
end
