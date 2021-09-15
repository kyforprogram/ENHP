# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

4.times do |n|
User.create!([
  email: "a#{n+1}@a",
  password: "aaaaaa#{n+1}",
  name: "名前#{n+1}",
  ])
end

4.times do |n|
Post.create!([
  title: "TITLE",
  company_name: "LTD CO ",
  introduction: "HELLO WORLD",
  assignment: "ビジネス相手を探している",
  target: "#ハッシュタグ#{n+1}",
  user_id: "#{n+1}"
  ])
end