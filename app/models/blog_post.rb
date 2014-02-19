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
    @title   = details.fetch(:title).force_encoding("UTF-8")
    @summary = details.fetch(:summary).force_encoding("UTF-8")
    @url     = details.fetch(:url).force_encoding("UTF-8")
    @time    = details.fetch(:time)
  end

  attr_reader :title, :summary, :url, :time
end
