class ApplicationController < ActionController::API
  private

  def authenticate
    @user = User.find(params[:current_user_id])

    unless @user && @user.authenticate(params[:current_user_password])
      render json: 'You need to login to do this action', status: 404
    end
  end
end
