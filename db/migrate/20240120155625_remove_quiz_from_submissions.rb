class RemoveQuizFromSubmissions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :submissions, :quiz, null: false, foreign_key: true
  end
end
