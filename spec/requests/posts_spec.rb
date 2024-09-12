require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create :user }
  
  describe "POST /create" do
    it "creates a post with valid parameters" do
      post_params = { user_id: user.id, title: "Amazing Post", body: "I'm going to tell you about the greatest ideas ever" }

      token = sign_in user
      
      expect {
        post posts_path, params:{ post: post_params }, headers: { authorization: token }
        new_post = Post.last
        expect(new_post.user).to eq user
        expect(new_post.title).to eq post_params[:title]
        expect(new_post.body).to eq post_params[:body]
      }.to change { Post.count }.from(0).to(1)
    end

    it "renders the post errors for invalid params" do
      token = sign_in user

      expect {
        post posts_path, params: { post: {user_id: user.id }}, headers: { authorization: token }
        expect(response.body).to eq "{\"errors\":{\"message\":[\"Title can't be blank\",\"Body can't be blank\"]}}"
      }.not_to change { Post.count }
    end

    it "creates a TimelineItem" do
      token = sign_in user
      
      post_params = { user_id: user.id, title: "Amazing Post", body: "I'm going to tell you about the greatest ideas ever" }

      expect {
        post posts_path, params:{ post: post_params }, headers: { authorization: token }
        new_post = Post.last
        expect(new_post.user).to eq user
        expect(new_post.title).to eq post_params[:title]
        expect(new_post.body).to eq post_params[:body]
      }.to change { TimelineItem.count }.from(0).to(1)
    end
  end
end
