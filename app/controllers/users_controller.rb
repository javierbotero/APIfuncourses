class UsersController < ApplicationController
  before_action :authenticate, only: [:update, :show, :destroy]

  def login
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      render json: { user: @user }
    else
      render json: { error: 'User not found :(' }, status: 404
    end
  end

  def create
    @user = User.new(user_params)
    @user.avatar.attach(
      io: StringIO.new(Base64.decode64(params[:avatar][:io])),
      filename: params[:avatar][:filename],
      content_type: "image/jpg",
    )

    if @user.save
      render json: { user: @user }
    else
      render json: { error: @user.errors.full_messages.join(' ') }, status: 404
    end
  end

  def show
    @user = User.find(params[:current_user_id])

    render json: { user: @user }
  end

  def update
    @user = User.find(params[:current_user_id])

    if @user.update(user_params)
      render json: { user: @user }
    else
      render json: { error: @user.errors.full_messages.join(' ') }, status: 404
    end
  end

  def destroy
    @user = User.find(params[:current_user_id])
    @user.destroy

    render json: { response: 'The user was deleted' }
  end

  def friends
    @user = User.find(params[:current_user_id])

    render json: { friends: @user.friends }
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end
end
