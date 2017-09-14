class AddStartDateToLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :start_date, :datetime, null: false
    add_index  :lessons, :start_date
  end
end
