FactoryBot.define do
  factory :post do
    title { Faker::Lorem.word }
    body { Faker::Lorem.words.join(' ') }
    posted_at { Time.now }

    trait :with_comments do
      after :create do |post|
        create_list :comment, 3, user: create(:user), post: post, message: Faker::Lorem.words.join(' '), commented_at: Time.now

        post.reload
      end
    end
  end
end
