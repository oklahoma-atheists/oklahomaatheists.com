class Zazzle
  Product = Struct.new(:title, :price, :link, :thumbnail_url)

  BASE_URL = "http://www.zazzle.com"

  def initialize(store_url_name)
    @store_url_name = store_url_name
  end

  attr_reader :store_url_name
  private     :store_url_name

  def store_url
    "#{BASE_URL}/#{store_url_name}"
  end

  def products
    Array(feed.items).map { |item| parse_product(item) }
  end

  private

  def connection
    Faraday.new(url: BASE_URL)
  end

  def feed
    parse_rss(connection.get(feed_path).body)
  end

  def feed_path
    "/#{store_url_name}/rss"
  end

  def parse_rss(raw_rss)
    SimpleRSS.parse(raw_rss)
  end

  def parse_product(rss_item)
    Product.new( rss_item[:title],
                 rss_item[:description][/\$\d+\.\d{2}/],
                 rss_item[:link],
                 rss_item[:media_thumbnail_url] )
  end
end
