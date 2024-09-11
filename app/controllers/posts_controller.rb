class PostsController < ApplicationController
    def create
        @post = Post.new posts_params
        @post.posted_at = Time.now

        if @post.save
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
