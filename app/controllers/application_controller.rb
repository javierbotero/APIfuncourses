class ApplicationController < ActionController::API
  before_action :authenticate_token

  private

  def authenticate
    @user = User.find(params[:current_user_id])

    unless @user && @user.authenticate(params[:current_user_password])
      render json: 'You need to login to do this action', status: 404
    end
  end

  def authenticate_token
    @token = Token.find(params[:token_id])
    unless @token.authenticate_token(params[:token])
      render json: 'You need a token to retrieve information :(', status: 404
    end
  end
end
