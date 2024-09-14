require 'rails_helper'

RSpec.describe User, type: :model do
  it "validates fields that are required" do
    user = build :user, name: nil

    user.save
    
    expect(user.errors).not_to be_empty
  end

  it "validates the email format" do
    user = build :user, email: "notanemail"

    user.save

    expect(user.errors.full_messages).to include "Email must be formatted properly, e.g. \"johndoe@example.com\""
  end

  context "#average_rating" do
    let!(:user) { create :user, :with_ratings }

    it "provides the correct value" do
      sum = 0
      user.user_ratings.each {|user_rating| sum += user_rating.rating } 

      expect(user.average_rating).to eq sum / user.user_ratings.size
    end
  end
end
