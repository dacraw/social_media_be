class GithubEvent < ApplicationRecord
    has_many :timeline_items, as: :timelineable
    belongs_to :user
end
