class BlogPost
  def self.recent
    posts = AOK::APIs.blogger.posts
    Array(posts).map { |post|
      new( title:   post.title,
           summary: post.summary,
           url:     post.url,
           time:    post.time )
    }
  end

  def initialize(details)
    @title   = details.fetch(:title)
    @summary = details.fetch(:summary)
    @url     = details.fetch(:url)
    @time    = details.fetch(:time)
  end

  attr_reader :title, :summary, :url, :time
end
