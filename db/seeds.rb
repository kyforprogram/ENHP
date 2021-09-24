# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"
CSV.foreach('db/category.csv') do |row|
  Category.create(:id => row[0], :name => row[1], :ancestry => row[2])
end


Admin.create!([
  email: "a@a",
  password: "aaaaaa"
  ])

50.times do |n|
User.create!([
  email: "a#{n+1}@a",
  password: "aaaaaa#{n+1}",
  name: "日本太郎#{n+1}",
  company: "LTD CO ",
  ])
end

50.times do |n|
Post.create!([
  title: "TITLE",
  introduction: "HELLO WORLD",
  assignment: "ビジネス相手を探している",
  target: "#ハッシュタグ",
  user_id: "1"
  ])
end

20.times do |n|
  Like.create!([
    user_id: "1",
    post_id: "#{n+1}"
    ])
end


