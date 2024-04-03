require 'rails_helper'

RSpec.describe VideoPolicy do
  subject { described_class.new(user, video) }

  let(:video) { create(:video, user: user) }

  context 'when user is an admin' do
    let(:user) { create(:user, role: :admin) }

    it { is_expected.to permit_actions([:index, :show, :serve_video, :create, :update, :destroy]) }
  end

  context 'when user is staff' do
    let(:user) { create(:user, role: :staff) }

    it { is_expected.to permit_actions([:index, :show, :serve_video, :create, :update]) }
    it { is_expected.to forbid_action(:destroy) }

    context 'and does not own the video' do
      let(:other_user) { create(:user, role: :staff) }
      let(:video) { create(:video, user: other_user) }

      it { is_expected.to forbid_action(:update) }
    end
  end

  describe 'Scope' do
    let(:scope) { VideoPolicy::Scope.new(user, Video).resolve }

    context 'when user is an admin' do
      let(:user) { create(:user, role: :admin) }

      it 'includes all videos' do
        expect(scope).to include(video)
        # Add more examples as needed
      end
    end

    context 'when user is staff' do
      let(:user) { create(:user, role: :staff) }
      let(:other_video) { create(:video) } # Video belonging to another user

      it 'includes only videos belonging to the user' do
        expect(scope).to include(video)
        expect(scope).not_to include(other_video)
      end
    end
  end
end
