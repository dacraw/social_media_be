require 'rails_helper'

RSpec.describe "UserRatings", type: :request do
  let!(:user) { create :user }
  let!(:rater) { create :user }

  describe "POST /create" do
    let!(:token) { sign_in user}

    it "creates a User Rating" do
      user_ratings_params = { user_rating: { user_id: user.id,rater_id: rater.id, rating: 4 } }
      
      expect {
        post user_ratings_path, params: user_ratings_params, headers: { authorization: token }
      }.to change { UserRating.count }.from(0).to(1)
    end

    it "renders an error if the user rating is not created" do
      user_ratings_params = { user_rating: { user_id: user.id, rater_id: rater.id } }
      post user_ratings_path, params: user_ratings_params, headers: { authorization: token }

      expect(response.status).to eq 400
      expect(JSON.parse(response.body)["errors"]["message"]).to be_present
    end

    it "does not allow a user to rate themself" do
      user_ratings_params = { user_rating: { user_id: user.id, rater_id: user.id, rating: 4 } }
      post user_ratings_path, params: user_ratings_params, headers: { authorization: token }

      expect(response.status).to eq 400
      expect(JSON.parse(response.body)["errors"]["message"]).to eq "You cannot rate yourself."
    end

    it "does not allow a user to rate the same user more than once" do
      create :user_rating, user: user, rater: rater, rating: 4, rated_at: Time.now

      user_ratings_params = { user_rating: { user_id: user.id, rater_id: rater.id, rating: 4 } }
      post user_ratings_path, params: user_ratings_params, headers: { authorization: token }

      expect(JSON.parse(response.body)["errors"]["message"]).to eq "You have already rated this user."
    end

    context "when the user surpasses an average rating of 4.0" do
      let!(:user) { create :user }
      let!(:user_rating) { create :user_rating, user: user, rating: 4, rater: create(:user), rated_at: Time.now}

      it "creates a timeline item" do
        user.reload

        token = sign_in user

        user_rating_params = {user_rating: {user_id: user.id, rating: 5, rater_id: create(:user).id,rated_at: Time.now} }

        expect {
          post user_ratings_path, params: user_rating_params, headers: { authorization: token }

          timeline_item = TimelineItem.last

          expect(timeline_item.timelineable).to eq user
          expect(timeline_item.event).to eq TimelineItem::SURPASS_4_STARS
        }.to change { TimelineItem.count }.from(0).to(1)
      end
    end
  end
end
