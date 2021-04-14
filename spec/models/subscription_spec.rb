require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'Tests for Subscription' do
    before(:all) do
      @tony = create(:user, username: 'tony', email: 'tony@gmail.com')
      @course = create(:course, link: 'zoom.com/3', content: 'Content 3')
      @subscription = create(:subscription, user: @tony, course: @course, confirmed: false)
    end

    after(:all) do
      User.destroy_all
      Course.destroy_all
      Subscription.destroy_all
    end

    it 'Checks Tony is the user' do
      expect(@subscription.user).to eq(@tony)
    end

    it 'Checks @course is the subscription\'s course' do
      expect(@subscription.course).to eq(@course)
    end

    it 'Checks subscription approval' do
      expect(@subscription.confirmed).to be false
      @subscription.update(confirmed: true)
      expect(@subscription.confirmed).to be true
    end
  end
end
