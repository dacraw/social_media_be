require 'rails_helper'

RSpec.describe "UserRatings", type: :request do
  let!(:user) { create :user }
  let!(:rater) { create :user }

  describe "POST /create" do
    it "creates a User Rating" do
      expect {
        post user_ratings_path, params: 
          { user_rating: 
            {
              user_id: user.id,
              rater_id: rater.id,
              rating: 4
            }
          }
    }.to change { UserRating.count }.from(0).to(1)
    end

    it "renders an error if the user rating is not created" do
      post user_ratings_path, params: 
        { user_rating: 
          {
            user_id: user.id,
            rater_id: rater.id,
          }
        }

      expect(response.status).to eq 400
      expect(response.body).to eq "{\"error\":{\"message\":\"There was an error creating the user rating.\"}}"
    end

    context "when the user surpasses an average rating of 4.0" do
      let!(:user) { create :user }
      let!(:user_rating) { create :user_rating, user: user, rating: 4, rater: create(:user), rated_at: Time.now}
      it "creates a timeline item" do
        user.reload

        expect {
          post user_ratings_path, params: {
            user_rating: {
              user_id: user.id, 
              rating: 5, 
              rater_id: create(:user).id, 
              rated_at: Time.now
            }
          }

          timeline_item = TimelineItem.last

          expect(timeline_item.timelineable).to eq user
          expect(timeline_item.event).to eq TimelineItem::SURPASS_4_STARS
        }.to change { TimelineItem.count }.from(0).to(1)


      end
    end
  end
end
