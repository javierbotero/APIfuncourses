require 'rails_helper'

RSpec.describe 'Friendships', type: :request do
  before(:all) do
    post '/tokens'
    data = JSON.parse(response.body)
    @token = data['token']
    @id = data['id']
    @user = create(:user, username: 'Javier 6', email: 'jav6@gmail.com')
    @receiver = create(:user, username: 'Ana 6', email: 'ana6@gmail.com')
    @receiver2 = create(:user, username: 'Michael', email: 'mic@gmail.com')
    @friendship = create(:friendship, sender: @user, receiver: @receiver2, confirmed: false)
  end
  after(:all) do
    User.destroy_all
    Friendship.destroy_all
  end
  describe 'Tests for Friendships controller' do
    it 'Checks friendships#create with route post /friendships, sender_id should be @user.id' do
      post '/friendships', params: {
        token: @token,
        token_id: @id,
        current_user_id: @user.id,
        current_user_password: 'password',
        receiver_id: @receiver.id
      }
      expect(JSON.parse(response.body)['friendship']['sender_id']).to eq(@user.id)
    end

    it 'Checks friendships#update with request put /friendships/:id, verifies email new friend is jav6@gmail.com' do
      put "/friendships/#{@friendship.id}", params: {
        token: @token,
        token_id: @id,
        current_user_id: @receiver2.id,
        current_user_password: 'password'
      }
      expect(JSON.parse(response.body)['new_friend']['email'] == 'jav6@gmail.com').to be true
    end

    it 'Checks friendships#destroy action with route delete /friendships/:id' do
      delete "/friendships/#{@friendship.id}", params: {
        token: @token,
        token_id: @id,
        current_user_id: @user.id,
        current_user_password: 'password'
      }
      expect(JSON.parse(response.body)['response'] == 'Friendship rejected').to be true
    end
  end
end
