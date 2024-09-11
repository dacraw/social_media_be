FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.name }
    registered_at { Time.now }   
    user_ratings { [] } 

    trait :with_ratings do
      after :create do |user|
        ratings = create_list :user_rating, 3, user: user, rater: create(:user), rating: rand(1..5), rated_at: Time.now
        user.user_ratings = ratings

        user.save
        user.reload
      end
    end
  end
end
