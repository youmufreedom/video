require 'rails_helper'

RSpec.feature 'Videos', type: :feature do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, role: 'admin') }
  let(:organisation) { create(:organisation) }

  before do
    user.organisation = organisation
    user.save

    login_as(user, scope: :user)
  end

  scenario 'User views the index page' do
    create(:video, title: 'Sample Video', user: user, organisation: organisation)
    visit videos_path
    expect(page).to have_text('Sample Video')
  end

  scenario 'User creates a new video' do
    visit new_video_path
    fill_in 'Title', with: 'New Video Title'
    fill_in 'Description', with: 'A description of the new video.'

    attach_file 'File', Rails.root.join('spec/fixtures/files/sample_video.mp4')
    attach_file 'Thumbnail', Rails.root.join('spec/fixtures/files/sample_thumbnail.jpg')
    attach_file 'Overlay', Rails.root.join('spec/fixtures/files/sample_overlay.jpg')
    click_button 'Upload Video'
    expect(page).to have_link('Back to Videos')
    expect(page).to have_text('Your browser does not support the video tag')
  end

  scenario 'User updates a video' do
    video = create(:video, title: 'Old Title', user: user, organisation: organisation)
    visit edit_video_path(video)
    fill_in 'Title', with: 'Updated Video Title'
    click_button 'Update Video'
    expect(page).to have_link('Back to Videos')
    expect(page).to have_text('Your browser does not support the video tag')
  end

  scenario 'User deletes a video' do
    login_as(admin_user, scope: :user)
    create(:video, title: 'Delete Me', user: user, organisation: organisation)
    visit videos_path
    expect(page).to have_text('Delete Me')
    click_link 'Delete'
    expect(page).to have_text('Your browser does not support the video tag')
  end
end
