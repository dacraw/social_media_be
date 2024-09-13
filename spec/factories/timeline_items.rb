FactoryBot.define do
  factory :timeline_item do
    user
  end

  trait :for_create_post do
    event { TimelineItem::CREATE_POST }
    timelineable {create(:post, user: self.user)}
    message { timelineable.title }
    date { Time.now }
  end

  trait :for_comment_on_post do
    event { TimelineItem::COMMENT_ON_POST }
    timelineable {create(:comment, user: self.user, post: create(:post, user: create(:user)), commented_at: Time.now, message: Faker::Lorem.words.join(' '))}
    message { "Commented on a post by Hank Jennings" }
    date { Time.now }
  end

  trait :for_surpassing_4_stars do
    event { TimelineItem::SURPASS_4_STARS }
    timelineable { self.user }
    message { "Passed 4 stars!" }
    date { Time.now }
  end
end
