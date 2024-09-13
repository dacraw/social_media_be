class AddDateToTimelineItem < ActiveRecord::Migration[7.1]
  def change
    add_column :timeline_items, :date, :datetime
  end
end
