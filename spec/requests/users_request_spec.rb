require 'rails_helper'
require 'json'

RSpec.describe 'Users', type: :request do
  before(:all) do
    post '/tokens'
    data = JSON.parse(response.body)
    @token = data['token']
    @id = data['id']
    @user = create(:user, username: 'Richard', email: 'richard@gmail.com')
  end

  after(:all) do
    Token.destroy_all
    User.destroy_all
  end

  describe 'tests for Users controller' do
    it 'tests users#login action route /login  response with a user with id' do
      post '/login', params: { token: @token, token_id: @id, username: @user.username, password: 'password' }
      expect(JSON.parse(response.body)['user']['id']).to eq(@user.id)
    end

    it 'Checks response of users#create with route /signup returns a user with correct username' do
      post '/signup',
           params: { token: @token, token_id: @id,
                     user: {
                       username: 'Ronald',
                       password: 'password',
                       password_confirmation: 'password',
                       email: 'ron@gmail.com'
                     } }
      expect(JSON.parse(response.body)['user']['username']).to eq('Ronald')
    end

    it 'Checks users#show returns correct user id' do
      post '/user',
           params: { token: @token, token_id: @id, current_user_id: @user.id, current_user_password: 'password' }
      expect(JSON.parse(response.body)['user']['id']).to eq(@user.id)
    end

    it 'Checks users#update when name changes to Ronaldo' do
      put "/users/#{@user.id}", params: {
        token: @token,
        token_id: @id,
        current_user_id: @user.id,
        current_user_password: 'password',
        user: { username: 'Ronaldo', password: 'password', password_confirmation: 'password',
                email: 'ronaldo@gmail.com' }
      }
      expect(JSON.parse(response.body)['user']['username'] == 'Ronaldo').to be true
    end

    it 'Checks users#destroy through /users/:id returns correct response' do
      delete "/users/#{@user.id}", params: {
        token: @token,
        token_id: @id,
        current_user_id: @user.id,
        current_user_password: 'password'
      }
      expect(JSON.parse(response.body)['response'] == 'The user was deleted').to eq true
    end
  end
end
