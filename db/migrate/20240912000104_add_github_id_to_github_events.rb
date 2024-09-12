class AddGithubIdToGithubEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :github_events, :github_id, :string
    add_index :github_events, :github_id
  end
end
