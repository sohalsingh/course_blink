class CreateLessonHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :lesson_histories do |t|
      t.references :lesson, null: false, foreign_key: true
      t.references :enrollment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
