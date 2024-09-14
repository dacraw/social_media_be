require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create :user }

  describe "GET /index" do
    it "returns posts" do
      token = sign_in user

      posts = create_list :post, 3, user: user

      get posts_path, headers: { authorization: "Bearer #{token}"}

      expect(JSON.parse(response.body)["data"].size).to eq posts.size
    end
  end

  describe "GET /show" do
    let(:token) { sign_in user}

    it "returns information for a post" do
      user = create :user, :with_ratings
      post = create :post, user: user

      get post_path(id: post.id), headers: { authorization: "Bearer #{token}"}

      parsed_data = JSON.parse response.body
      expect(parsed_data["id"].to_i).to eq post.id
      expect(parsed_data["title"]).to eq post.title
      expect(parsed_data["body"]).to eq post.body
      expect(parsed_data["user_id"].to_i).to eq post.user_id
      expect(parsed_data["user_average_rating"]).to eq post.user.average_rating
      expect(parsed_data["post_user_name"]).to eq post.user.name
    end

    it "returns an error for nonexistent posts" do
      get post_path(id: 12345), headers: { authorization: token }

      expect(response.status).to eq 400
      expect(JSON.parse(response.body)["errors"]["message"]).to include "That post does not exist."
    end
  end
  
  describe "POST /create" do
    let(:token) { sign_in user }
    it "creates a post with valid parameters" do
      post_params = { user_id: user.id, title: "Amazing Post", body: "I'm going to tell you about the greatest ideas ever" }

      expect {
        post posts_path, params:{ post: post_params }, headers: { authorization: token }
        new_post = Post.last
        expect(new_post.user).to eq user
        expect(new_post.title).to eq post_params[:title]
        expect(new_post.body).to eq post_params[:body]
      }.to change { Post.count }.from(0).to(1)
    end

    it "renders the post errors for invalid params" do
      expect {
        post posts_path, params: { post: {user_id: user.id }}, headers: { authorization: token }
        expect(response.body).to eq "{\"errors\":{\"message\":[\"Title can't be blank\",\"Body can't be blank\"]}}"
      }.not_to change { Post.count }
    end

    it "creates a TimelineItem" do
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
