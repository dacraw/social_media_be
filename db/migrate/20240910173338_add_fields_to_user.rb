class AddFieldsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :github_username, :string
    add_column :users, :registered_at, :datetime, null: false
  end
end
