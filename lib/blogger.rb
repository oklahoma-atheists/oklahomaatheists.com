class Blogger
  Post = Struct.new(:title, :summary, :url, :time)

  def initialize(blog_url)
    @blog_url = blog_url
  end

  attr_reader :blog_url

  def posts
    Array(feed.items).map { |item| parse_post(item) }
  end

  private

  def connection
    Faraday.new(url: blog_url)
  end

  def feed
    parse_atom(connection.get(feed_path).body)
  end

  def feed_path
    "/feeds/posts/default"
  end

  def parse_atom(raw_atom)
    SimpleRSS.parse(raw_atom)
  end

  def parse_post(rss_post)
    Post.new( rss_post[:title],
              rss_post[:summary],
              rss_post[:"link+alternate"],
              rss_post[:published] )
  end
end
