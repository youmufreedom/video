FactoryBot.define do
  factory :video do
    title { "Sample Video" }
    description { "This is a sample video description." }
    user
    organisation

    file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample_video.mp4'), 'video/mp4') }
    thumbnail { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample_thumbnail.jpg'), 'image/jpeg') }
    overlay { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample_overlay.jpg'), 'image/jpeg') }
  end
end
