require 'rails_helper'

RSpec.describe TranscodeVideoJob, type: :job do
  let!(:video) { create(:video) }
  let(:movie_double) { instance_double(FFMPEG::Movie) }

  before do
    allow(FFMPEG::Movie).to receive(:new).with(video.file.path).and_return(movie_double)
    allow(movie_double).to receive(:transcode)

    uploaded_file_dir = video.file.store_dir
    allow(File).to receive(:directory?).and_call_original
    allow(File).to receive(:directory?).with(uploaded_file_dir).and_return(true)

    allow(FileUtils).to receive(:mkdir_p)
    allow(FileUtils).to receive(:remove_dir)

    # Perform the job
    described_class.perform_now(video_id: video.id)
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  it 'initializes FFMPEG::Movie with the video file path' do
    expect(FFMPEG::Movie).to have_received(:new).with(video.file.path)
  end

  it 'creates the output directory' do
    output_dir = Rails.root.join('storage', 'videos', video.id.to_s)
    expect(FileUtils).to have_received(:mkdir_p).with(output_dir)
  end

  it 'transcodes the video' do
    output_file_path = Rails.root.join('storage', 'videos', video.id.to_s, 'transcoded_file.mp4').to_s
    expect(movie_double).to have_received(:transcode).with(output_file_path, hash_including(video_codec: "h264"))
  end

  it 'removes the uploaded file directory' do
    expect(FileUtils).to have_received(:remove_dir).with(video.file.store_dir, force: true)
  end
end
