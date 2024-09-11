require 'rails_helper'

RSpec.describe TimelineItem, type: :model do
  let(:user) { create :user }
  let(:timelineable) { create :post, user: user }
  
  it "creates a TimelineItem" do
    timeline_item = build :timeline_item, timelineable: timelineable, event: TimelineItem::CREATE_POST

    expect {
      timeline_item.save

      expect(timeline_item.timelineable).to eq timelineable
      expect(timeline_item.event).to eq TimelineItem::CREATE_POST
    }.to change {TimelineItem.count}.from(0).to(1)

  end
end
