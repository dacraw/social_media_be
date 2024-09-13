class User < ApplicationRecord
  has_secure_password
  
  validates_presence_of :email, :name, :registered_at
  validates_uniqueness_of :email
  validate :email_format

  has_many :user_ratings
  has_many :posts
  has_many :timeline_items
  has_many :github_events

  def average_rating
    sum = 0
    self.user_ratings.each {|user_rating| sum += user_rating.rating }

    (sum.to_f / self.user_ratings.size).round 2
  end

  private

  def email_format
    if !self.email.match? /.+@.+\..+/
      errors.add(:email, "must be formatted properly, e.g. \"johndoe@example.com\"")
    end
  end
end
