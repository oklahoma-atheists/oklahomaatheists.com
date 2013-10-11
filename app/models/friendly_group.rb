class FriendlyGroup
  def initialize(details)
    @name = details.fetch(:name)
    @url  = details.fetch(:url)
  end

  attr_reader :name, :url
end
