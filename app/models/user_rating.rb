class UserRating < ApplicationRecord
    belongs_to :user
    belongs_to :rater, class_name: "User"

    validates_presence_of :rating, :rated_at
end
