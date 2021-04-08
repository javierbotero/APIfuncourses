require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  before(:all) do
    post '/tokens'
    data = JSON.parse(response.body)
    @token = data['token']
    @id = data['id']
    @user = create(:user, username: 'Javier 8', email: 'jav8@gmail.com')
    @course = create(:course, link: 'zoom/com/7', content: 'Content 7', teacher: @user)
  end
  after(:all) do
    User.destroy_all
    Course.destroy_all
    Token.destroy_all
  end
  describe 'Tests for Courses' do
    it 'Checks courses#index with route post /courses' do
      post '/courses', params: {
        token: @token,
        token_id: @id
      }
      expect(JSON.parse(response.body)['courses'].is_a?(Array)).to be true
    end

    it 'Checks for courses#create with route post /courses/create' do
      post '/courses/create', params: {
        token: @token,
        token_id: @id,
        current_user_id: @user.id,
        current_user_password: 'password',
        images: [],
        main: {},
        course: {
          link: 'zoom/com/5',
          provider: 'zoom',
          title: 'Painting Mountains',
          content: 'Painting Mountains',
          status: 'Open',
          dates: '2021-10-12 2021-10-22 ',
          price: 10
        }
      }
      expect(JSON.parse(response.body)['course']['title'] == 'Painting Mountains').to be true
    end

    it 'Checks courses#update with route put /courses/:id' do
      put "/courses/#{@course.id}", params: {
        token: @token,
        token_id: @id,
        current_user_id: @user.id,
        current_user_password: 'password',
        images: [],
        main: {},
        course: {
          link: 'bluejeans/com/1',
          provider: 'bluejeans',
          title: 'Painting Mountains',
          content: 'Painting Mountains',
          status: 'Open',
          dates: '2021-10-12 2021-10-22 ',
          price: 10
        }
      }
      puts response.body
      result = JSON.parse(response.body)
      expect(result['course']['title'] == 'Painting Mountains').to be true
    end

    it 'Checks courses#destroy with route delete /courses/:id, user deletes he\'s course' do
      delete "/courses/#{@course.id}", params: {
        token: @token,
        token_id: @id,
        current_user_id: @user.id,
        current_user_password: 'password'
      }
      expect(JSON.parse(response.body)['response'] == 'Course has been destroyed').to be true
    end
  end
end
