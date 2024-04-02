class TranscodeVideoJob < ApplicationJob
  queue_as :default

  require 'fileutils'

  def perform(video_id:)
    video = Video.find(video_id)
    # Assuming `file` is the attribute for the uploaded video
    movie = FFMPEG::Movie.new(video.file.path)

    # Ensure the directory path is correctly set up
    output_dir = Rails.root.join('storage', 'videos', video_id.to_s)
    FileUtils.mkdir_p(output_dir)

    output_file_path = output_dir.join('transcoded_file.mp4').to_s

    # Transcode the video
    movie.transcode(output_file_path, { video_codec: "h264", preset: "slow", crf: 22 }) do |progress|
      puts progress # Log progress or use it to debug
    end

    video.remove_file!
  end
end
