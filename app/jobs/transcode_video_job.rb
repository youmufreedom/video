class TranscodeVideoJob < ApplicationJob
  queue_as :default

  require 'fileutils'

  def perform(video_id:)
    video = Video.find(video_id)
    movie = FFMPEG::Movie.new(video.file.path)

    output_dir = Rails.root.join('storage', 'videos', video_id.to_s)
    FileUtils.mkdir_p(output_dir)

    output_file_path = output_dir.join('transcoded_file.mp4').to_s

    # Transcode the video
    movie.transcode(output_file_path, { video_codec: "h264", preset: "slow", crf: 22 }) do |progress|
      puts progress # Log progress or use it to debug
    end

    video.remove_file = true
    video.save

    uploaded_file_dir = video.file.store_dir
    if File.directory?(uploaded_file_dir) && !uploaded_file_dir.blank?
      FileUtils.remove_dir(uploaded_file_dir, force: true)
    end
  rescue StandardError => e
    Rails.logger.error "Failed to clean up video storage: #{e.message}"
  end
end
