class PostsController < ApplicationController
    def create
        @post = Post.new posts_params
        @post.posted_at = Time.now

        if @post.save
            timeline_item = TimelineItem.new timelineable: @post, event: TimelineItem::CREATE_POST
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
