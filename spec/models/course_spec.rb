require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'Course tests with users and subscriptions' do
    before(:all) do
      @juan = create(:user, username: 'Juan')
      @catalina = create(:user, username: 'Catalina', email: 'cata@gmail.com')
      @kitchen_course = create(:course, teacher: @juan)
      create(:subscription, user: @catalina, course: @kitchen_course)
      create(:favorite, user: @catalina, course: @kitchen_course)
    end

    after(:all) do
      Course.destroy_all
      User.destroy_all
      Subscription.destroy_all
      Favorite.delete_all
    end

    it 'Checks Juan is the teacher of the Sushi course' do
      expect(@kitchen_course.teacher.username).to eq(@juan.username)
    end

    it 'Catalina has as a first subscription the course kitchen' do
      expect(@catalina.subscriptions.first.course).to eq(@kitchen_course)
    end

    it 'Checks Juan has as a first course as teacher kitchen course' do
      expect(@juan.courses.first).to eq(@kitchen_course)
    end

    it "Checks kitchen course is inside Catalina's favorites" do
      expect(@catalina.favorites.first.course).to eq(@kitchen_course)
    end
  end
end