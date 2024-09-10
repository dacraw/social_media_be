class RatingsController < ApplicationController
    def create

    end

    private

    def ratings_params
        require(:user_rating).permit(:user_id, :rating)
    end
end
