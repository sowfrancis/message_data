require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#CREATE" do

    before do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    end

    it "create a user" do
      post :create, params: {provider: :google}
      expect(User.count).to eq 1
    end

    it "should create a session" do
      session[:user_id] = nil
      post :create, params: {provider: :google}
      expect(session[:user_id]).to_not be_nil
    end

  end

end
