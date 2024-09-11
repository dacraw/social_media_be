class Post < ApplicationRecord
    belongs_to :user
    has_many :timeline_items, as: :timelineable

    validates_presence_of :title, :body, :posted_at
end
