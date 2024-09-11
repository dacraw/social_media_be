class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    has_many :timeline_items, as: :timelineable

    validates_presence_of :message, :commented_at
end
