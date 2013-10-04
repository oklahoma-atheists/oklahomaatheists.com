class NavLink
  def initialize(details)
    @title        = details.fetch(:title)
    @url          = details.fetch(:url)
    @footer       = details.fetch(:footer) { false }
    @nested_links = Array(details.fetch(:nested_links) { [ ] })
  end

  attr_reader :title, :url, :nested_links

  def footer?
    @footer
  end
end
