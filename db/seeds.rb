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

4.times do |n|
User.create!([
  email: "a#{n+1}@a",
  password: "aaaaaa#{n+1}",
  name: "Test#{n+1} test#{n*2}",
  company: "LTD CO ",
  ])
end

50.times do |n|
Post.create!([
  title: "TITLE",
  introduction: "HELLO WORLD",
  assignment: "ビジネス相手を探している",
  target: "#ハッシュタグ#{n+1}",
  user_id: "1"
  ])
end



