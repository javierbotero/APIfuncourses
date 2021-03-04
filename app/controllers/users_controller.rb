class UsersController < ApplicationController
  def loggin
    @user = User.find_by(username: params[:username], password: params[:password])

    if @user
      render json: @user
    else
      render json: 'User not found :('
    end
  end

  def create
    @user = User.new(user_params)
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
