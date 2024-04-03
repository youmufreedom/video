class VideoRetriever
  def self.call(video)
    new(video).call
  end

  def initialize(video)
    @video = video
  end

  def call
    transcoded_file_path = File.join('storage', 'videos', @video.id.to_s, 'transcoded_file.mp4')

    if @video.file?
      File.join('public', @video.file.url)
    elsif File.exist?(transcoded_file_path)
      transcoded_file_path
    end
  end
end
