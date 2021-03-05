require 'rails_helper'

RSpec.describe "Users", type: :request do
  before(:all) do
    @user = create(:user)
  end

  after(:all) do
    User.destroy_all
  end

  describe "POST /login" do
    it "returns http success" do
      headers = { 'Content-Type' => 'application/json' }
      post "/login", params: '{ "username": "Javier", "password": "password" }', headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /signup" do
    it "returns http success" do
      headers = { 'Content-Type' => 'application/json' }
      post "/signup", params: '{ "user": { "username": "Catalina", "password": "password", "email": "cata@gmail.com" }}', headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT /update" do
    it "returns http success" do
      headers = { "Content-Type" => "application/json" }
      put "/users/#{@user.id}", params: '{ "user": { "username": "Juan", "password": "password", "email": "juan@gmail.com" } }', headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      delete "/users/#{@user.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
