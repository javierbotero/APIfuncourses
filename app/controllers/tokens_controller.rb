class TokensController < ApplicationController
  skip_before_action :authenticate_token, only: :create

  def create
    token = SecureRandom.hex
    @token = Token.new(token: token)

    @token.save
    render json: { id: @token.id, token: token }
  end

  def destroy
    @token = Token.find(params[:token_id])
    @token.destroy

    render json: 'Token destroyed, thanks for contributing to clean the Database'
  end
end