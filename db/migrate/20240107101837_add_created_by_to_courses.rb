class AddCreatedByToCourses < ActiveRecord::Migration[7.0]
  def change
    add_reference :courses, :created_by, null: true, foreign_key: true, foreign_key: { to_table: :users }
  end
end
