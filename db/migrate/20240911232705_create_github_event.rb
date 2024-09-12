class CreateGithubEvent < ActiveRecord::Migration[7.1]
  def change
    create_table :github_events do |t|
      t.string :repo_name
      t.string :branch, null: true
      t.string :event_name, null: false

      t.timestamps
    end
  end
end
