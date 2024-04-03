require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:organisation) }
    it { is_expected.to have_many(:category_videos) }
    it { is_expected.to have_many(:categories).through(:category_videos) }
  end

  describe 'ActiveStorage attachments' do
    it { is_expected.to have_one_attached(:file) }
    it { is_expected.to have_one_attached(:thumbnail) }
    it { is_expected.to have_one_attached(:overlay) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    # Uncomment if using active_storage_validations for attachment presence validation
    # it { is_expected.to validate_attached_of(:file) }
  end

  # CarrierWave uploaders
  describe 'uploaders' do
    subject { create(:video) } # Adjust if your factory requires specific attributes

    it 'mounts the file uploader' do
      expect(subject.file).to be_an_instance_of(VideoFileUploader)
    end

    it 'mounts the thumbnail uploader' do
      expect(subject.thumbnail).to be_an_instance_of(ThumbnailUploader)
    end

    it 'mounts the overlay uploader' do
      expect(subject.overlay).to be_an_instance_of(OverlayUploader)
    end
  end
end
