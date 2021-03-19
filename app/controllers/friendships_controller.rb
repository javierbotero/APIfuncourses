class FriendshipsController < ApplicationController
  before_action :authenticate
  include Helpers

  def create
    @user = User.find(params[:current_user_id])

    unless @user.pending_requested_friendships.any?{ |f| f.receiver_id == params[:receiver_id].to_i }
      @friendship = @user.pending_requested_friendships.build(receiver_id: params[:receiver_id])

      if @friendship.save
        render json: { friendship: @friendship }
      else
        render json: { error: 'Friendship could not be completed :(' }, status: 404
      end
    else
      render json: { error: 'This action can not be repeated' }, status: 404
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @new_friend = User.find(@friendship.sender_id)
    new_friend_info = new_friend_filtered(@new_friend)

    if is_user_receiver_id(@friendship) && @friendship.update(confirmed: true)
      render json: { new_friend: new_friend_info }
    else
      render json: { error: 'Friendship was not updated :(' }, status: 404
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])

    if is_user_receiver_or_sender(@friendship)
      @friendship.destroy
      render json: { response: 'Friendship rejected' }
    else
      render json: { error: 'You are not allowed to execute this action' }, status: 404
    end
  end
end
