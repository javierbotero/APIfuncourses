require 'rails_helper'

RSpec.describe 'Tokens', type: :request do
  it 'Returns http succes' do
    post '/tokens'
    expect(response).to have_http_status(:success)
  end
end