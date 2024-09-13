class CommentsController < ApplicationController

    
    def create
        post = Post.find params[:post_id]
        
        comment = Comment.new comment_params
        comment.post = post
        comment.commented_at = Time.now

        if comment.save
            TimelineItem.create timelineable: comment, event: TimelineItem::COMMENT_ON_POST, user: comment.user, date: Time.now

            render json: comment.as_json.merge("user_average_rating" => comment.user.average_rating), status: 200
        else
            render json: { errors: { message: comment.errors.full_messages }}, status: 400
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:user_id, :message)
    end
end
