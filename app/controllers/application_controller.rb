class ApplicationController < ActionController::API
  private

  def authenticate
    @user = User.find(params[:current_user_id])

    unless @user && @user.authenticate(params[:current_user_password])
      render json: 'You are not allowed to execute this action', status: 404
    end
  end
end
