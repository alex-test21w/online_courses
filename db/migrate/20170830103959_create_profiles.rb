class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string  :first_name
      t.string  :last_name

      t.timestamps
    end

    add_index :profiles, :user_id
  end
end
