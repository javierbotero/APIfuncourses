class FavoritesController < ApplicationController
  before_action :authenticate
  include Helpers

  def create
    @user = User.find(params[:current_user_id])

    if @user.favorites.any? { |fav| fav.course_id == params[:course_id] }
      render json: { error: 'This course was already liked' }, status: 404
    else
      @favorite = @user.favorites.build(course_id: params[:course_id])
      if @favorite.save
        render json: { favorite: @favorite }
      else
        render json: { error: 'Action not allowed' }, status: 404
      end
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    course_id = @favorite.course_id

    if match_user_ids(@favorite.user_id)
      @favorite.destroy

      render json: { favorite_id: params[:id], course_id: course_id }
    else
      render json: { error: 'You are not allowed to execute this action' }, status: 404
    end
  end
end
