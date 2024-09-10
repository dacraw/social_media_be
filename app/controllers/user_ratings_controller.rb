class UserRatingsController < ApplicationController
    def create

    end

    private

    def user_ratings_params
        require(:user_rating).permit(:user_id, :rating)
    end
end
