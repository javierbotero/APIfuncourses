require 'rails_helper'

RSpec.describe Token, type: :model do
  describe 'Tests Token' do
    before(:all) do
      @token = Token.create
    end
    after(:all) do
      Token.delete_all
    end
    it 'Checks token is created' do
      expect(Token.first.id).to eq(@token.id)
    end
  end
end
