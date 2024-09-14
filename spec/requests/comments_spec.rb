require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create :user }

  describe "GET /index" do
    let!(:post_with_comments) { create :post, :with_comments, user: user}
    let(:token) { sign_in user }

    it "retrieves comments for a post" do
      get post_comments_path(post_id: post_with_comments.id), headers: { authorization: "Bearer #{token}"}

      parsed_data = JSON.parse response.body
      expect(parsed_data.size).to eq post_with_comments.comments.size
      expect(parsed_data.pluck("post_id").all? {|id| id.to_i == post_with_comments.id }).to eq true
    end

    it "returns an error for a non-existent post" do
      get post_comments_path(post_id: 12345), headers: { authorization: "Bearer #{token}" }
      
      expect(response.status).to eq 400
      expect(JSON.parse(response.body)["errors"]["message"]).to include "That post does not exist."
    end
  end

  describe "GET /show" do
    it "responds with information about the given comment" do
      post = create :post, user: create(:user)
      comment = create :comment, post: post, user: user, message: Faker::Lorem.words.join(' ')
      token = sign_in user
      get post_comment_path(post_id: post.id, id: comment.id), headers: { authorization: "Bearer #{token}" }
      
      parsed_data = JSON.parse response.body
      expect(parsed_data["user_id"].to_i).to eq comment.user.id
      expect(parsed_data["post_id"].to_i).to eq comment.post.id
      expect(parsed_data["message"]).to eq comment.message
    end
  end

  describe "POST /create" do
    let(:existing_post) { create :post, user: create(:user) }

    it "creates a comment" do
      comment_params = {
        user_id: user.id,
        post_id: existing_post.id,
        message: "Wow this post is so great"
      }

      token = sign_in(user)

      expect {
        post post_comments_path(post_id: existing_post.id), params: {comment: comment_params}, headers: { authorization: "Bearer #{token}"}

        comment = Comment.last
        
        parsed_data = JSON.parse response.body
        expect(parsed_data["user_id"].to_i).to eq comment.user.id
        expect(parsed_data["post_id"].to_i).to eq comment.post.id
        expect(parsed_data["message"]).to eq comment.message
      }.to change { Comment.count }.from(0).to(1)
    end

    it "creates a timeline item" do
      comment_params = {
        post_id: existing_post.id,
        message: "Wow this post is so great"
      }

      token = sign_in(existing_post.user)
      
      expect {
        post post_comments_path(post_id: existing_post.id), params: {comment: comment_params}, headers: { authorization: "Bearer #{token}"}
      }.to change { TimelineItem.count }.from(0).to(1)     

      timeline_item = TimelineItem.last
      expect(timeline_item.user).to eq existing_post.user
      expect(timeline_item.event).to eq TimelineItem::COMMENT_ON_POST
      expect(timeline_item.timelineable).to eq Comment.last
    end

    context "when a commenter has an average rating" do
      let(:user) { create :user, :with_ratings }

      it "returns the user rating in the response" do
        comment_params = {
          post_id: existing_post.id,
          message: "Wow this post is so great"
        }

        token = sign_in(user)
      
        expect {
          post post_comments_path(post_id: existing_post.id), params: {comment: comment_params}, headers: { authorization: "Bearer #{token}"}
        }.to change { Comment.count }.from(0).to(1)   

        expect(JSON.parse(response.body)["user_average_rating"].to_f).to eq user.average_rating
      end
    end
  end
end
