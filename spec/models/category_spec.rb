require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:category_videos) }
    it { is_expected.to have_many(:videos).through(:category_videos) }
  end
end
