class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :description
      t.string :video
      t.string :photo
      t.string :pdf
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
