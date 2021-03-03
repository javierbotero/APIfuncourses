class ChangeDefaultToConfirmedInFriendshipTable < ActiveRecord::Migration[6.1]
  def change
    change_column_null :friendships, :confirmed, false
  end
end
