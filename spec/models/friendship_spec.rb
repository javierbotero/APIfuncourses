require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'Tests for Friendship' do
    before(:all) do
      @paola = create(:user, username: 'Paola', email: 'paola@gmail.com')
      @simon = create(:user, username: 'Simon', email: 'simon@gmail.com')
      @friendship = create(:friendship, receiver: @paola, sender: @simon, confirmed: false)
    end

    after(:all) do
      User.destroy_all
      Friendship.destroy_all
    end

    it 'Checks Paola is receiver' do
      expect(@friendship.receiver).to eq(@paola)
    end

    it 'Checks Simon is sender' do
      expect(@friendship.sender).to eq(@simon)
    end

    it 'Checks confirmation before and after being confirmed' do
      expect(@friendship.confirmed).to be false
      @friendship.update(confirmed: true)
      expect(@friendship.confirmed).to be true
    end
  end
end