class AddStateToHomeworks < ActiveRecord::Migration[5.1]
  def change
    add_column :homeworks, :state, :string
  end
end
