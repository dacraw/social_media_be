FactoryBot.define do
  factory :post do
    title { Faker::Lorem.word }
    body { Faker::Lorem.words.join(' ') }
    posted_at { Time.now }
  end
end
