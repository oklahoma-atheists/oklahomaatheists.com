class Video
  def self.recent
    AOK::APIs.youtube.refresh_access_token!
    videos = AOK::APIs.youtube
                      .videos_by(user: ENV.fetch("YOUTUBE_USERNAME"))
                      .videos
    Array(videos).map { |video|
      new( name:     video.title,
           time:     video.published_at,
           embedder: video.method(:embed_html5) )
    }
  end

  def initialize(details)
    @name     = details.fetch(:name)
    @time     = details.fetch(:time)
    @embedder = details.fetch(:embedder)
  end

  attr_reader :name, :time

  attr_reader :embedder
  private     :embedder

  def embed_html(*args)
    embedder.call(*args)
  end
end
