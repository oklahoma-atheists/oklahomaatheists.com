class Product
  def self.all
    products = AOK::APIs.zazzle.products
    Array(products).map { |product|
      new( name:      product.title,
           price:     product.price,
           url:       product.link,
           photo_url: product.thumbnail_url )
    }
  end

  def self.random(count, products = all)
    products.group_by(&:name).values.sample(count).map(&:sample).shuffle
  end

  def initialize(details)
    @name      = details.fetch(:name)
    @price     = details.fetch(:price)
    @url       = details.fetch(:url)
    @photo_url = details.fetch(:photo_url)
  end

  attr_reader :name, :price, :url, :photo_url
end
