class AddOutcastToCourseUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :course_users, :outcast, :boolean, default: false
  end
end
