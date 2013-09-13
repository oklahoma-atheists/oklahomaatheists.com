class SocialMediaAccount
  def initialize(details)
    @service        = details.fetch(:service)
    @url            = details.fetch(:url)
    @call_to_action = details.fetch(:call_to_action)
    @css_class      = details.fetch(:css_class)
  end

  attr_reader :service, :url, :call_to_action, :css_class
end
