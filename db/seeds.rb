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

20.times do |n|
User.create!([
  email: "a#{n+1}@a",
  password: "aaaaaa",
  name: "日本太郎#{n+1}",
  profile_image: File.open("./app/assets/images/profile_image.jpg"),
  company: "日本太郎カンパニー#{n+1}",
  introduction: "はじめまして！　私の名前は日本太郎#{n+1}と申します　よろしくお願いいたします。"
  ])
end

20.times do |n|
Post.create!([
  title: "TITLE",
  introduction: "HELLO WORLD",
  image: File.open("./app/assets/images/icon.jpg"),
  assignment: "オープンイノベーションを活用して新たな価値あるものを作りたい",
  target: "#オープンイノベーション　#HELLO",
  category_id:"#{n+1}",
  user_id: "#{n+1}"
  ])
end

20.times do |n|
  Like.create!([
    user_id: "1",
    post_id: "#{n+1}"
    ])
end


