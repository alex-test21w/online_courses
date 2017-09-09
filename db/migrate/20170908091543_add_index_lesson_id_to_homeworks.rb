class AddIndexLessonIdToHomeworks < ActiveRecord::Migration[5.1]
  def change
    add_column :homeworks, :lesson_id, :integer
    add_index :homeworks, :lesson_id
  end
end
