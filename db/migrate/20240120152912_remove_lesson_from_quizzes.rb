class RemoveLessonFromQuizzes < ActiveRecord::Migration[7.0]
  def change
    remove_column :quizzes, :lesson_id, :integer
  end
end
