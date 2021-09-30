class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
    t.string "title", null: false
    t.string "image_id"
    t.text "introduction", null: false
    t.text "assignment", null: false
    t.string "target", null: false
    t.integer "category_id", null: false
    t.integer "user_id", null: false
    t.timestamps
    end
  end
end
