class AddReadTimeToLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :read_time, :float
  end
end
