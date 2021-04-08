require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  before(:all) do
    post '/tokens'
    data = JSON.parse(response.body)
    @token = data['token']
    @id = data['id']
    @user = create(:user, username: 'Javier 9', email: 'jav9@gmail.com')
    @course = create(:course, link: 'zoom.com/8', content: 'Content 8', teacher: @user)
    @course2 = create(:course, link: 'zoom.com/9', content: 'Content 9', teacher: @user)
    @comment = create(:comment, course: @course2, user: @user, body: 'Comment to be edited')
  end
  after(:all) do
    User.destroy_all
    Course.destroy_all
    Favorite.destroy_all
  end
  describe 'Tests for Comments controller' do
    it '' do
      post '/comments', params: {
        token: @token,
        token_id: @id,
        current_user_id: @user.id,
        current_user_password: 'password',
        comment: {
          course_id: @course.id,
          body: 'New comment'
        }
      }
      expect(JSON.parse(response.body)['comment']['body'] == 'New comment').to be true
    end

    it 'Checks comments#update with route put /comments/:id, to change @comment.body' do
      put "/comments/#{@comment.id}", params: {
        token: @token,
        token_id: @id,
        current_user_id: @user.id,
        current_user_password: 'password',
        comment: {
          course_id: @course2.id,
          body: 'Comment edited'
        }
      }
      puts @comment.body
      expect(@comment.reload.body == 'Comment edited').to be true
    end

    it 'Checks for comments#destroy with route delete /comments/:id' do
      delete "/comments/#{@comment.id}", params: {
        token: @token,
        token_id: @id,
        current_user_id: @user.id,
        current_user_password: 'password'
      }
      expect(JSON.parse(response.body)['response'] == 'Comment deleted').to be true
    end
  end
end
