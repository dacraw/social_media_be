require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  let!(:user) { create :user }
  
  describe "POST /index" do
    it "signs in a user" do
      post login_path, params: { authentication: { email: user.email, password: user.password }}

      parsed_body = JSON.parse response.body
      expect(parsed_body["token"]).to be_present
      expect(parsed_body["message"]).to eq "Successfully logged in"

      parsed_user = parsed_body["user"]
      expect(parsed_user["id"].to_i).to eq user.id
      expect(parsed_user["email"]).to eq user.email
      expect(parsed_user["name"]).to eq user.name
    end
  end
end
