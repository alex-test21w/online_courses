class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profile do |t|
      t.integer :user_id
      t.string  :first_name
      t.string  :last_name

      t.timestamps
    end

    add_index :profile, :user_id
  end
end
