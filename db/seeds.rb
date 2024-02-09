# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Clear existing data
User.destroy_all

# Create 4 users
users = []
4.times do |i|
  user = User.new(
    name: "User#{i + 1}",
    email: "user#{i + 1}@example.com",
    password: "password",
    password_confirmation: "password"
  )
  user.skip_confirmation!
  user.save!

  users << user
end

image_paths = [
  Rails.root.join("app", "assets", "images", "rest1-burgerzone.jpg"),
  Rails.root.join("app", "assets", "images", "rest2-goichisuchi.jpg"),
  Rails.root.join("app", "assets", "images", "rest3-panadicto.jpg"),
  Rails.root.join("app", "assets", "images", "rest4-eggandcheese.jpg")
]

# Create categories and transactions for each user
users.each do |user|
  4.times do |i|
    category = user.categories.create!(
      name: "Category#{i + 1}",
      icon: File.open(image_paths[i]) # Open local image file
    )

    4.times do |j|
      category.deals.create!(
        author_id: "#{j + 1}",
        name: "Deal#{j + 1}",
        amount: rand(1.0..100.0).round(2)
      )
    end
  end
end
