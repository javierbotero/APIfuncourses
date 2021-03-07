module Helpers
  def is_user_receiver_or_sender(friendship)
    user = User.find(params[:current_user_id])
    user.id == friendship.sender_id || user.id == friendship.receiver_id ? true : false
  end

  def is_user_receiver_id(friendship)
    user = User.find(params[:current_user_id])
    friendship.receiver_id == @user.id ? true : false
  end

  def macth_user_ids(id = nil)
    params[:current_user_id].to_i == id
  end
end