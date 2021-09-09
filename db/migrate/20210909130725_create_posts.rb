class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
    t.string "title"
    t.string "company_name"
    t.string "image_id"
    t.text "introduction"
    t.text "assignment"
    t.text "target"
    t.integer "user_id"
      t.timestamps
    end
  end
end
