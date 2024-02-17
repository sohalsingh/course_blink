class CreateCourseImpressions < ActiveRecord::Migration[7.0]
  def change
    create_table :course_impressions do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :viewed_at
      t.string :ip_address

      t.timestamps
    end
  end
end
