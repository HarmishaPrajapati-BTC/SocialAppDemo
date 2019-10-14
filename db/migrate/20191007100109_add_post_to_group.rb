class AddPostToGroup < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :group, foreign_key: true
  end
end
