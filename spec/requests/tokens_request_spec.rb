require 'rails_helper'

RSpec.describe 'Tokens', type: :request do
  it 'Returns http succes' do
    post '/tokens'
    expect(response).to have_http_status(:success)
  end

  it 'Deletes Token' do
    str = SecureRandom.hex
    token = Token.create(token: str)
    delete "/tokens/#{token.id}", params: { token: token, token_id: token.id }
    expect(JSON.parse(response.body)['response'] == 'Token destroyed, thanks for contributing to clean the Database').to be true
  end
end
