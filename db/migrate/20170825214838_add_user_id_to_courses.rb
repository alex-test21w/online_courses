class AddUserIdToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :user_id, :integer
    add_index :courses, :user_id
  end
end
