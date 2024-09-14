class Post < ApplicationRecord
    belongs_to :user
    has_many :timeline_items, as: :timelineable
    has_many :comments

    validates_presence_of :title, :body, :posted_at
end
