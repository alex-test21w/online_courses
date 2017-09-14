class AddStateToLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :state, :string
    add_index  :lessons, :state
  end
end
