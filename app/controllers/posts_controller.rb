class PostsController < ApplicationController
    skip_before_action :authenticate_user!
    
    def show
        @post = Post.find_by_id params[:id]

        if !@post
            return render json: { errors: { message: "That post does not exist."} }, status: 400
        end

        render json: @post.as_json.merge({ "user_average_rating" => @post.user.average_rating})
    end
    
    def create
        @post = Post.new posts_params
        @post.posted_at = Time.now

        if @post.save
            timeline_item = TimelineItem.new timelineable: @post, event: TimelineItem::CREATE_POST, user: @post.user, date: Time.now
            if !timeline_item.save
                return render json: { errors: { message: @timeline_item.errors.full_messages} }, status: 400
            end
            
            render json: @post
        else
            render json: { errors: { message: @post.errors.full_messages} }, status: 400
        end
    end

    private

    def posts_params
        params.require(:post).permit(:user_id, :title, :body)
    end
end
