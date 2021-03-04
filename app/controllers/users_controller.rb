class UsersController < ApplicationController
  def loggin
    @user = User.find_by(username: params[:username], password: params[:password])

    if @user
      render json: @user
    else
      render json: 'User not found :(', status: 404
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: @user.errors.full_messages, status: 404
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors.full_messages, status: 404
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    render json: 'The user was deleted'
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
