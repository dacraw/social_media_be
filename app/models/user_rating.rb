class UserRating < ApplicationRecord
    belongs_to :user
    belongs_to :rater, class_name: "User"

    validates_presence_of :rating, :rated_at

    validates_inclusion_of :rating, in: 1..5
end
