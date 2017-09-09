class AddSubscriptionToCourseUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :course_users, :subscription, :boolean, default: false
  end
end
