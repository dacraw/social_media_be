class AddMessageToTimelineItems < ActiveRecord::Migration[7.1]
  def change
    add_column :timeline_items, :message, :string
  end
end
