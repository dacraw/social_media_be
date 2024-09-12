class AddUserToGithubEvents < ActiveRecord::Migration[7.1]
  def change
    add_reference :github_events, :user, null: false, foreign_key: true
  end
end
