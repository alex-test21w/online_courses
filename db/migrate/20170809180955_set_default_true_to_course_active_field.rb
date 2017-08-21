class SetDefaultTrueToCourseActiveField < ActiveRecord::Migration[5.1]
  def change
    change_column :courses, :active, :boolean, default: true, null: false
  end
end
