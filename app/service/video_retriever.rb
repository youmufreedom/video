class VideoRetriever
  def self.call(video)
    new(video).call
  end

  def initialize(video)
    @video = video
  end

  def call
    transcoded_video_path = File.join('storage', 'videos', @video_id.to_s, 'transcoded_file.mp4')
    original_video_path = File.join('public', 'uploads', 'video', 'file', @video.id.to_s)

    if File.exist?(original_video_path)
      original_video_path.to_s
    else
      transcoded_video_path.to_s
    end
  end
end
