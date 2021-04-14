require 'rails_helper'

RSpec.describe 'Subscriptions', type: :request do
  before(:all) do
    post '/tokens'
    data = JSON.parse(response.body)
    @token = data['token']
    @id = data['id']
    @user = create(:user, username: 'Javier 5', email: 'javi5@gmail.com')
    @teacher = create(:user, username: 'Ana 4', email: 'ana4@gmail.com')
    @course = create(:course, content: 'New content 4', link: 'zoom/com/4', teacher: @teacher)
    @subs = create(:subscription, user: @user, course: @course, confirmed: false)
  end

  after(:all) do
    User.destroy_all
    Course.destroy_all
    Subscription.destroy_all
  end

  describe 'Tests for Subscriptions' do
    it 'Checks subscriptions#create with the request post /subscriptions' do
      post '/subscriptions',
           params: {
             token: @token,
             token_id: @id,
             current_user_id: @user.id,
             current_user_password: 'password',
             course_id: @course.id
           }
      expect(JSON.parse(response.body)['pending_subscription']['course_id']).to eq(@course.id)
    end

    it 'Checks subscription#update with request put /subscriptions/:id, teacher confirms' do
      expect(@subs.confirmed).to be(false)
      put "/subscriptions/#{@subs.id}",
          params: {
            token: @token,
            token_id: @id,
            current_user_id: @teacher.id,
            current_user_password: 'password'
          }
      expect(JSON.parse(response.body)['updated_subscription']['confirmed']).to be(true)
    end

    it 'Checks subscriptions#destroy with request delete /subscriptiona/:id, user destroys the subscription' do
      delete "/subscriptions/#{@subs.id}",
             params: {
               token: @token,
               token_id: @id,
               current_user_id: @user.id,
               current_user_password: 'password'
             }
      expect(JSON.parse(response.body)['response'] == 'Subscription deleted').to be true
    end
  end
end
