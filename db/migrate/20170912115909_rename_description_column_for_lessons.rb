class RenameDescriptionColumnForLessons < ActiveRecord::Migration[5.1]
  def change
    rename_column :lessons, :descriprion, :description
  end
end
