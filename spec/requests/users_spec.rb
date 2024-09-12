require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create :user}

  describe "POST /create" do
    it "creates a new user" do
      expect {
        post users_path, params: { user: { name: "Doug", email: "dougiefresh@example.com", registered_at: Time.now, password: "password"}}
    }.to change { User.count }.from(0).to(1)

    parsed_data = JSON.parse response.body
    expect(parsed_data["user"]["password_digest"]).not_to be_present
    end
  end
  
  describe "GET /timeline" do
    it "provides the user's timeline" do
      get "/users/#{user.id}/timeline"
    end
  end
end
