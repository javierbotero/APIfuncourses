require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /loggin" do
    it "returns http success" do
      get "/users/loggin"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /signup" do
    it "returns http success" do
      get "/users/signup"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/users/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/users/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
