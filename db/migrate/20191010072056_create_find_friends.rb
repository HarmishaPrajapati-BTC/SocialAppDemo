class CreateFindFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :find_friends do |t|

      t.timestamps
    end
  end
end
