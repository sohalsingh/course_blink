class AddTitleToQuiz < ActiveRecord::Migration[7.0]
  def change
    change_column :quizzes, :title, :string, null: false
  end
end
