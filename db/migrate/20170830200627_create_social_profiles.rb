class CreateSocialProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :social_profiles do |t|
      t.integer :user_id
      t.string  :uid
      t.string  :service_name

      t.timestamps
    end

    add_index :social_profiles, :user_id
    add_index :social_profiles, [:user_id, :service_name], unique: true
  end
end
