require 'rails_helper'

RSpec.describe User, type: :model do
  it "validates fields that are required" do
    user = build :user

    user.save

    expect(user.errors).not_to be_empty
  end
end
