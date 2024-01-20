class RenameColumnsInQuestions < ActiveRecord::Migration[7.0]
  def change
    rename_column :questions, :content, :title
    rename_column :options, :content, :title
  end
end
