require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    before do
      @organisation = create(:organisation)
    end

    it 'creates a new user' do
      expect {
        post :create, params: { user: { email: 'test@example.com', password: 'password123', password_confirmation: 'password123', organisation_id: @organisation.id } }
      }.to change(User, :count).by(1)
    end

    it 'create a new user with default role staff' do
      post :create, params: { user: { email: 'test@example.com', password: 'password123', password_confirmation: 'password123', organisation_id: @organisation.id } }

      user = User.last
      expect(user.role).to eq('staff')
    end

    it 'redirects to the videos path after sign up' do
      post :create, params: { user: { email: 'test@example.com', password: 'password123', password_confirmation: 'password123', organisation_id: @organisation.id, role: 'staff' } }
      expect(response).to redirect_to(videos_path)
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: { email: 'invalid', password: 'password', password_confirmation: 'mismatch' } }
        }.to_not change(User, :count)
      end
    end
  end
end
