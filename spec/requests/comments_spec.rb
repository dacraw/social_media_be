require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create :user }
  let(:existing_post) { create :post, user: create(:user) }

  describe "POST /create" do
    it "creates a comment" do
      comment_params = {
        user_id: user.id,
        post_id: existing_post.id,
        message: "Wow this post is so great"
      }

      token = sign_in(user)

      expect {
        post post_comments_path(post_id: existing_post.id), params: {comment: comment_params}, headers: { authorization: "Bearer #{token}"}

        expect(Comment.last.post).to eq existing_post
      }.to change { Comment.count }.from(0).to(1)
    end

    it "creates a timeline item" do
      comment_params = {
        user_id: user.id,
        post_id: existing_post.id,
        message: "Wow this post is so great"
      }

      token = sign_in(user)
      
      expect {
        post post_comments_path(post_id: existing_post.id), params: {comment: comment_params}, headers: { authorization: "Bearer #{token}"}
      }.to change { TimelineItem.count }.from(0).to(1)     

      timeline_item = TimelineItem.last
      expect(timeline_item.user).to eq user
      expect(timeline_item.event).to eq TimelineItem::COMMENT_ON_POST
      expect(timeline_item.timelineable).to eq Comment.last
    end
  end
end
