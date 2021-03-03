class CorrectChangeDefaultInFriendshipTable < ActiveRecord::Migration[6.1]
  def change
    change_column_default :friendships, :confirmed, false
  end
end
