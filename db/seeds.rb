# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if User.count == 0
    User.create! email: "johndoe@example.com", name: "John Doe", github_username: "", registered_at: Date.parse("2024-09-10"), created_at: Date.parse("2024-09-10"), updated_at: Date.parse("2024-09-10"), password: "password"

    User.create! email: "janedoe@example.com", name: "Jane Doe", github_username: "", registered_at: Date.parse("2024-09-10"), created_at: Date.parse("2024-09-10"), updated_at: Date.parse("2024-09-10"), password: "password"

    User.create! email: "beebo@example.com", name: "Beebo", github_username: "", registered_at: Date.parse("2024-09-10"), created_at: Date.parse("2024-09-10"), updated_at: Date.parse("2024-09-10"), password: "password"

    User.create! email: "rado@example.com", name: "Silverado", github_username: "", registered_at: Date.parse("2024-09-10"), created_at: Date.parse("2024-09-10"), updated_at: Date.parse("2024-09-10"), password: "password"
end

if UserRating.count == 0 
    UserRating.create! user: User.find_by_email("johndoe@example.com"), rater: User.find_by_email("janedoe@example.com"), rating: 5, rated_at: Date.parse("2024-09-10"),	created_at: Date.parse("2024-09-10"), updated_at: Date.parse("2024-09-10")

    UserRating.create! user: User.find_by_email("johndoe@example.com"), rater: User.find_by_email("rado@example.com"), rating: 3, rated_at: Date.parse("2024-09-10"),	created_at: Date.parse("2024-09-10"), updated_at: Date.parse("2024-09-10")
end

if Post.count == 0 
    Post.create! title: "Amazing post",	body: "Super incredible content here about cats", user: User.find_by_email("johndoe@example.com"), posted_at: Date.parse("2024-09-10"), created_at: Date.parse("2024-09-10"), updated_at: Date.parse("2024-09-12")
end

if Comment.count == 0
    Comment.create! user: User.find_by_email("beebo@example.com"), post: Post.first, message: "Wowowow this is amazing!", commented_at: Date.parse("2024-09-10"), created_at: Date.parse("2024-09-10"), updated_at: Date.parse("2024-09-12")
end