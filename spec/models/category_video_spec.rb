require 'rails_helper'

RSpec.describe CategoryVideo, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:video) }
    it { is_expected.to belong_to(:category) }
  end
end
