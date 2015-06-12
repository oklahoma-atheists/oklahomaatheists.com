class Video
  def self.recent
    videos = AOK::APIs.youtube
                      .videos_by(user: ENV.fetch("YOUTUBE_USERNAME"))
                      .videos
    Array(videos).map { |video|
      new( name:             video.title,
           time:             video.published_at,
           placeholder_html: video.embed_html5(
                               width: "**PLACEHOLDER_WIDTH**",
                               height: "**PLACEHOLDER_HEIGHT**"
                             ) )
    }
  rescue OpenURI::HTTPError
    [ ]
  end

  def initialize(details)
    @name             = details.fetch(:name)
    @time             = details.fetch(:time)
    @placeholder_html = details.fetch(:placeholder_html)
  end

  attr_reader :name, :time

  attr_reader :placeholder_html
  private     :placeholder_html

  def embed_html(details)
    width  = details.fetch(:width)
    height = details.fetch(:height)
    placeholder_html.gsub("**PLACEHOLDER_WIDTH**",  width.to_s)
                    .gsub("**PLACEHOLDER_HEIGHT**", height.to_s)
  end
end
