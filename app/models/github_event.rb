class GithubEvent < ApplicationRecord
    has_many :timeline_items, as: :timelineable
end
