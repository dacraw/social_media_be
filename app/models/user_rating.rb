class UserRating < ApplicationRecord
    belongs_to :user
    belongs_to :rater, class_name: "User"
end
