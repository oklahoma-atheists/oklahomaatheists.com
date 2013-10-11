class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :load_social_media

  def render(*)
    loader.finish_loading
    super
  end

  private

  def loader
    @loader ||= ExternalResourceLoader.new(self)
  end

  def load_social_media
    loader.start_loading(:tweets)     { Tweet.recent    }
    loader.start_loading(:blog_posts) { BlogPost.recent }
  end
end
