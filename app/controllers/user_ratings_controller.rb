class UserRatingsController < ApplicationController
    def create
        @user_rating = UserRating.new(user_ratings_params)
        @user_rating.rated_at = Time.now

        if @user_rating.save
            render json: @user_rating
        else
            render json: { error: { message: "There was an error creating the user rating." } }, status: 400
        end
    end

    private

    def user_ratings_params
        params.require(:user_rating).permit(:user_id, :rater_id, :rating)
    end
end
