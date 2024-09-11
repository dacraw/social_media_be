class CreateTimelineItems < ActiveRecord::Migration[7.1]
  def change
    create_table :timeline_items do |t|
      t.references :timelineable, polymorphic: true
      t.string :event, null: false

      t.timestamps
    end
  end
end
