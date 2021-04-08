require 'rails_helper'

RSpec.describe 'Favorites', type: :request do
  before(:all) do
    post '/tokens'
    data = JSON.parse(response.body)
    @token = data['token']
    @id = data['id']
    @user = create(:user, username: 'Javier 7', email: 'jav7@gmail.com')
    @course = create(:course, content: 'Content 4', link: 'zoom.com/4', teacher: @user)
    @user2 = create(:user, username: 'Jorge', email: 'jorg@gmail.com')
    @favorite = create(:favorite, user: @user2, course: @course)
  end
  after(:all) do
    User.destroy_all
    Course.destroy_all
    Favorite.destroy_all
    Token.destroy_all
  end
  describe 'Tests for Favorites controller' do
    it 'Checks favorites#create with route post /favorites' do
      post '/favorites', params: {
        token: @token,
        token_id: @id,
        current_user_id: @user.id,
        current_user_password: 'password',
        course_id: @course.id
      }
      expect(JSON.parse(response.body)['favorite']['user_id']).to eq(@user.id)
    end

    it 'Checks favorites#destroy with route delete /favorites/:id' do
      delete "/favorites/#{@favorite.id}", params: {
        token: @token,
        token_id: @id,
        current_user_id: @user2.id,
        current_user_password: 'password'
      }
      expect(JSON.parse(response.body)['favorite_id'].to_i).to eq(@favorite.id)
    end
  end
end
