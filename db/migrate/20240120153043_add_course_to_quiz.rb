class AddCourseToQuiz < ActiveRecord::Migration[7.0]
  def change
    add_reference :quizzes, :course, null: false, foreign_key: true
  end
end
