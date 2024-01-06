class CreateSubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :submissions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end
  end
end
