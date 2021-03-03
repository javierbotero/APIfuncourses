class AddToFriendshipsForeignKeyReceiverId < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :friendships, :users, column: :receiver_id
  end
end
