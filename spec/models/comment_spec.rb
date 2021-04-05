require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'tests for Comment' do
    before(:all) do
      @javier = create(:user, username: 'Jhon', email: 'jhon@gmail.com')
      @course = create(:course, teacher: @javier, link: 'zoom.com/1', content: 'Content 1')
      @comment = create(:comment, user: @javier, course: @course)
    end

    after(:all) do
      User.destroy_all
      Course.destroy_all
      Comment.destroy_all
    end

    it 'Checks @course has a comment' do
      expect(@course.comments.length).to eq(1)
    end

    it 'Checks Javier is the user' do
      expect(@comment.user).to eq(@javier)
    end

    it 'Checks @course is the course' do
      expect(@comment.course).to eq(@course)
    end
  end
end