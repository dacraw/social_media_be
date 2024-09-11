class AddUserIdToTimelineItem < ActiveRecord::Migration[7.1]
  def change
    add_reference :timeline_items, :user, null: false, foreign_key: true
  end
end
