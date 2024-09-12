class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates_presence_of :email, :name, :registered_at

  has_many :user_ratings
  has_many :posts
  has_many :timeline_items
  has_many :github_events

  def average_rating
    sum = 0
    self.user_ratings.each {|user_rating| sum += user_rating.rating }

    (sum.to_f / self.user_ratings.size).round 2
  end
end
