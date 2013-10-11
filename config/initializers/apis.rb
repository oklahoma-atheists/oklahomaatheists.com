RMeetup::Client.api_key = ENV.fetch("MEETUP_API_KEY")

Twitter.configure do |config|
  config.consumer_key       = ENV.fetch("TWITTER_CONSUMER_KEY")
  config.consumer_secret    = ENV.fetch("TWITTER_CONSUMER_SECRET")
  config.oauth_token        = ENV.fetch("TWITTER_OAUTH_TOKEN")
  config.oauth_token_secret = ENV.fetch("TWITTER_OAUTH_TOKEN_SECRET")
end

module AOK
  module APIs
    module_function

    def meetup
      @meetup ||= RMeetup::Client
    end

    def twitter
      @twitter ||= Twitter
    end

    def youtube
      @youtube ||= YouTubeIt::OAuth2Client.new(
        client_access_token:  ENV.fetch("YOUTUBE_CLIENT_ACCESS_TOKEN"),
        client_refresh_token: ENV.fetch("YOUTUBE_CLIENT_REFRESH_TOKEN"),
        client_id:            ENV.fetch("YOUTUBE_CLIENT_ID"),
        client_secret:        ENV.fetch("YOUTUBE_CLIENT_SECRET"),
        dev_key:              ENV.fetch("YOUTUBE_DEV_KEY")
      )
    end

    def zazzle
      @zazzle ||= Zazzle.new(ENV.fetch("ZAZZLE_USERNAME"))
    end

    def blogger
      @blogger ||= Blogger.new(ENV.fetch("BLOGGER_BLOG_URL"))
    end
  end
end
