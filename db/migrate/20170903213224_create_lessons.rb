class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.string :title, null: false
      t.integer :position, null: false
      t.text :descriprion
      t.string :picture
      t.string :synopsis
      t.text :homework
      t.integer :course_id, null: false

      t.timestamps
    end

    add_index :lessons, :course_id
  end
end
