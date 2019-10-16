class CreateSharePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :share_posts do |t|
      t.text :users, array: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
