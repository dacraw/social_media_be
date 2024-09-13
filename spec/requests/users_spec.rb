require 'rails_helper'
require "./spec/mocks/requests/users_spec_mocks.rb"

RSpec.describe "Users", type: :request do
  let(:user) { create :user}

  describe "POST /create" do
    it "creates a new user" do
      expect {
        post "/register", params: { user: { name: "Doug", email: "dougiefresh@example.com", registered_at: Time.now, password: "password"}}
      }.to change { User.count }.from(0).to(1)

      parsed_data = JSON.parse response.body 
      expect(parsed_data["user"]["password_digest"]).not_to be_present
      expect(parsed_data["token"]).to be_present
      
    end
  end
  
  describe "GET /timeline" do
    let(:user) { create :user }
    
    context "when the user has a github username" do
      let!(:user) { create :user, github_username: "skibidi"}

      it "returns timeline containing users's Github public events" do
        token = sign_in user
        
        expect(Octokit).to receive(:user_events).with(user.github_username) { UsersSpecMocks.mock_github_user_events }
        
        get "/users/#{user.id}/timeline", headers: { authorization: token }
        
        parsed_body = JSON.parse response.body

        expected_timeline_events = [TimelineItem::CREATE_NEW_GITHUB_REPOSITORY, TimelineItem::OPEN_NEW_GITHUB_PULL_REQUEST, TimelineItem::MERGE_GITHUB_PULL_REQUEST, TimelineItem::PUSH_GITHUB_COMMITS_TO_BRANCH]

        user_timeline_events = parsed_body["data"].pluck("event")

        expected_timeline_events.each do |expected_event|
          expect(user_timeline_events).to include expected_event
        end
      end
    end

    context "when the user has existing timeline items" do
      let(:token) { sign_in user }

      it "sorts timeline items chronologically descending by timeline item date" do
        item_create_post = create(:timeline_item, :for_create_post, user: user, date: Date.parse("2024-09-13"))
        item_comment_on_post = create(:timeline_item, :for_comment_on_post, user: user, date: Date.parse("2024-09-14"))
        item_surpassing_4_stars = create(:timeline_item, :for_surpassing_4_stars, user: user, date: Date.parse("2024-09-15"))

        get "/users/#{user.id}/timeline", headers: { authorization: token }

        parsed_body = JSON.parse(response.body)["data"]

        expect(parsed_body.first["id"].to_i).to eq item_surpassing_4_stars.id
        expect(parsed_body.second["id"].to_i).to eq item_comment_on_post.id
        expect(parsed_body.third["id"].to_i).to eq item_create_post.id
      end
      
      it "returns a timeline containing item for create post" do
        timeline_create_post = create(:timeline_item, :for_create_post, user: user)

        get "/users/#{user.id}/timeline", headers: { authorization: token }

        timeline_item = JSON.parse(response.body)["data"].first
        expect(timeline_item["event"]).to eq TimelineItem::CREATE_POST
        expect(timeline_item["message"]).to eq timeline_create_post.timelineable.title
        expect(timeline_item["user_id"].to_i).to eq user.id 
      end

      it "returns a timeline containing item for commenting on a post" do
        create(:timeline_item, :for_comment_on_post, user: user)

        get "/users/#{user.id}/timeline", headers: { authorization: token }

        timeline_item = JSON.parse(response.body)["data"].first
        expect(timeline_item["event"]).to eq TimelineItem::COMMENT_ON_POST
        expect(timeline_item["message"]).to eq "Commented on a post by Hank Jennings"
        expect(timeline_item["user_id"].to_i).to eq user.id 
      end

      it "returns a timeline containing item for surpassing 4 stars" do
        create(:timeline_item, :for_surpassing_4_stars, user: user)

        get "/users/#{user.id}/timeline", headers: { authorization: token }

        timeline_item = JSON.parse(response.body)["data"].first
        expect(timeline_item["event"]).to eq TimelineItem::SURPASS_4_STARS
        expect(timeline_item["message"]).to eq "Passed 4 stars!"
        expect(timeline_item["user_id"].to_i).to eq user.id 
      end

      it "paginates timeline results 7 at a time" do
        timeline_items = create_list :timeline_item, 14, :for_create_post, user: user

        get "/users/#{user.id}/timeline", headers: { authorization: token }

        parsed_data = JSON.parse response.body
        expect(parsed_data["data"].size).to eq 7
        expect(parsed_data["data"].first["id"]).to eq timeline_items[13].id

        get "/users/#{user.id}/timeline", headers: { authorization: token }, params: { page: {page: 2} }
        parsed_data = JSON.parse response.body
        
        expect(parsed_data["links"]["next"]).to eq nil
        expect(parsed_data["data"].last["id"].to_i).to eq timeline_items.first.id
      end
    end
  end
end
