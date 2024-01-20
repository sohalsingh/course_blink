class AddOptionToSubmissions < ActiveRecord::Migration[7.0]
  def change
    add_reference :submissions, :option, null: false, foreign_key: true
    add_reference :submissions, :question, null: false, foreign_key: true
    add_column :submissions, :is_correct, :boolean, default: false
  end
end
