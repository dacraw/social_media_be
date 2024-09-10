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
    User.create! email: "johndoe@example.com", name: "John Doe", github_username: "jdddd", registered_at: Date.parse("2024-09-10"), created_at: Date.parse("2024-09-10"), updated_at: Date.parse("2024-09-10"), password: "password"
end