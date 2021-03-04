require 'rails_helper'

RSpec.describe User, type: :model do
  context 'User' do
    before(:each) do
      javier = create(:user)
    end

    it 'Check user Javier has Andrea as friend' do
      expect(javier.friends).to eq(0)
    end
  end
end
