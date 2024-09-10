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
  end
end
