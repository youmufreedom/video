require 'rails_helper'

RSpec.describe VideosController, type: :controller do
  let(:user_admin) { create(:user, role: 'admin') }
  let(:user_staff) { create(:user, role: 'staff') }

  let(:video_admin) { create(:video, user: user_admin) }
  let(:video_staff) { create(:video, user: user_staff) }

  before do
    sign_in user_admin
  end

  describe 'GET #index' do
    it 'assigns all videos as @videos' do
      get :index
      expect(assigns(:videos)).to eq([video_admin])
    end
  end

  describe 'GET #new' do
    it 'assigns a new video as @video' do
      get :new
      expect(assigns(:video)).to be_a_new(Video)
    end
  end

  describe 'POST #create' do
    before do
      sign_in user_admin
    end

    context 'with valid params' do
      it 'creates a new Video with an attached file' do
        expect {
          post :create, params: { video: attributes_for(:video) }
        }.to change(Video, :count).by(1)

        expect(Video.last.file).to be_present
      end

      it 'redirects to the created video' do
        post :create, params: { video: attributes_for(:video) }
        expect(response).to redirect_to(Video.last)
      end
    end

    context 'with invalid params' do
      it "re-renders the 'new' template" do
        # Assuming :title is required
        post :create, params: { video: attributes_for(:video, title: nil) }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested video as @video' do
      get :show, params: { id: video_admin.to_param }
      expect(assigns(:video)).to eq(video_admin)
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { title: 'Updated Title' }
      }

      it 'updates the requested video' do
        patch :update, params: { id: video_admin.to_param, video: new_attributes }
        video_admin.reload
        expect(video_admin.title).to eq('Updated Title')
      end

      it 'redirects to the video' do
        patch :update, params: { id: video_admin.to_param, video: new_attributes }
        expect(response).to redirect_to(video_admin)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested video' do
      video_admin # make sure the video is created
      expect {
        delete :destroy, params: { id: video_admin.to_param }
      }.to change(Video, :count).by(-1)
    end

    it 'does not allow a staff user to destroy the video and raises Pundit::NotAuthorizedError' do
      sign_in user_staff

      video_staff # make sure the video is created
      expect {
        delete :destroy, params: { id: video_staff.to_param }
      }.to raise_error(Pundit::NotAuthorizedError)
    end

    it 'redirects to the videos list' do
      delete :destroy, params: { id: video_admin.to_param }
      expect(response).to redirect_to(videos_url)
    end
  end
end
