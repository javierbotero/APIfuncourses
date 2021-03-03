class AddToFriendshipsForeignKeySenderId < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :friendships, :users, column: :sender_id
  end
end
