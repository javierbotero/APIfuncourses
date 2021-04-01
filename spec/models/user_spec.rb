require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User tests with friendships' do
    before(:all) do
      @javier = create(:user)
      @andrea = create(:user, username: 'Andrea', email: 'andrea@gmail.com')
      @friendship = create(:friendship, sender: @javier, receiver: @andrea)
    end

    after(:all) do
      Friendship.destroy_all
      User.destroy_all
    end

    it 'Checks Javier has one friend' do
      expect(@javier.requests.length + @javier.pendings.length).to eq(1)
    end

    it 'Checks the new friendship has Javier as sender' do
      expect(@friendship.sender).to eql(@javier)
    end

    it 'Checks the new friendship has Andrea as receiver' do
      expect(@friendship.receiver).to eql(@andrea)
    end

    it 'Checks Andrea has one request' do
      expect(@andrea.requests.length).to eql(1)
    end
  end
end
