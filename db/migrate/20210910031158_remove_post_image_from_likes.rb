class RemovePostImageFromLikes < ActiveRecord::Migration[5.2]
  def change
    change_table :likes do |t|
      t.rename :post_image_id, :post_id
    end
  end
end
