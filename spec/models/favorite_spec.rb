require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'Tests for Favorite' do
    before(:all) do
      @teacher = create(:user, username: 'mario', email: 'mario@gmail.com')
      @course = create(:course, link: 'zoom.com/2', content: 'Content 2', teacher: @teacher)
      @favorite = create(:favorite, user: @teacher, course: @course)
    end

    after(:all) do
      User.destroy_all
      Course.destroy_all
      Favorite.destroy_all
    end

    it 'Checks favorite\'s user is @teacher' do
      expect(@favorite.user).to eq(@teacher)
    end

    it 'Checks favorite\'s course is @course ' do
      expect(@favorite.course).to eq(@course)
    end
  end
end