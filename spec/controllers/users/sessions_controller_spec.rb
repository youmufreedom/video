require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user) # Assuming your user factory sets up a user correctly
  end

  describe "POST #create" do
    it "redirects to videos_path after successful sign in" do
      post :create, params: { user: { email: @user.email, password: @user.password } }
      expect(response).to redirect_to(videos_path)
    end
  end

  describe "DELETE #destroy" do
    it "redirects to user_session_path after sign out" do
      sign_in @user
      delete :destroy
      expect(response).to redirect_to(user_session_path)
    end
  end
end
