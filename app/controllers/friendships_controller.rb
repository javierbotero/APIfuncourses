class FriendshipsController < ApplicationController
  before_action :authenticate
  include Helpers

  def create
    @friendship = Friendship.new(sender_id: params[:sender_id], receiver_id: params[:receiver_id])

    if is_user_receiver_or_sender(@friendship) && @friendship.save
      render json: { friendship: @friendship }
    else
      render json: { error: 'Friendship could not be completed :(' }, status: 404
    end
  end

  def update
    @friendship = Friendship.find(params[:id])

    if is_user_receiver_id(@friendship) && @friendship.update(confirmed: true)
      render json: { response: 'Now you are friends!' }
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
