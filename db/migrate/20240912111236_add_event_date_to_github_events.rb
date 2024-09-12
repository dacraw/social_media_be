class AddEventDateToGithubEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :github_events, :date, :datetime
  end
end
