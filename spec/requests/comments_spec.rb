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

      expect {
        post comments_path, params: {comment: comment_params}
      }.to change { Comment.count }.from(0).to(1)
    end

    it "creates a timeline item" do
      comment_params = {
        user_id: user.id,
        post_id: existing_post.id,
        message: "Wow this post is so great"
      }

      expect {
        post comments_path, params: {comment: comment_params}
      }.to change { TimelineItem.count }.from(0).to(1)     
    end
  end
end
