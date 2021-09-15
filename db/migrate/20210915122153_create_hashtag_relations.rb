class CreateHashtagRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtag_relations do |t|

      t.timestamps
    end
  end
end
