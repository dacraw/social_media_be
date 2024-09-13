class UserRatingsController < ApplicationController
    def create
        if user_ratings_params[:user_id] == user_ratings_params[:rater_id]
            return render json: { errors: { message: "You cannot rate yourself."} }, status: 400
        end

        if UserRating.where(user_id: user_ratings_params[:user_id], rater_id: user_ratings_params[:rater_id]).present?
            return render json: { errors: { message: "You have already rated this user."} }, status: 400
        end
        
        user_rating = UserRating.new(user_ratings_params)
        user_rating.rated_at = Time.now

        if user_rating.save
            user_average = user_rating.user.average_rating
            if user_average > 4.0
                TimelineItem.create timelineable: user_rating.user, event: TimelineItem::SURPASS_4_STARS, user: user_rating.user, date: Time.now
            end
            
            render json: user_rating
        else
            render json: { errors: { message: "There was an error creating the user rating." } }, status: 400
        end
    end

    private

    def user_ratings_params
        params.require(:user_rating).permit(:user_id, :rater_id, :rating)
    end
end
