require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create :user}

  describe "GET /timeline" do
    it "provides the user's timeline" do
      get "/users/#{user.id}/timeline"
    end
  end
end
