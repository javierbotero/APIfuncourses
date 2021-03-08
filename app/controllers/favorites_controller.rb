class FavoritesController < ApplicationController
  before_action :authenticate
  include Helpers

  def create
    @user = User.find(params[:current_user_id])

    unless @user.favorites.any?{ |fav| fav.course_id == params[:course_id] }
      @favorite = @user.favorites.build(course_id: params[:course_id])
      if @favorite.save
        render json: @favorite
      else
        render json: 'Action not allowed', status: 404
      end
    else
      render json: 'This course was already included', status: 404
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])

    if match_user_ids(@favorite.user_id)
      @favorite.destroy

      render json: 'Not anymore in your favorites'
    else
      render json: 'You are not allowed do execute this action', status: 404
    end
  end
end
