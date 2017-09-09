class CreateHomeworks < ActiveRecord::Migration[5.1]
  def change
    create_table :homeworks do |t|
      t.text :description, null: false
      t.integer :user_id

      t.timestamps
    end

    add_index :homeworks, :user_id
  end
end
