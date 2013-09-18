class Tweet
  def self.recent
    tweets = AOK::APIs.twitter.user_timeline(
      ENV.fetch("TWITTER_USERNAME"),
      exclude_replies: true,
      include_rts:     false
    )
    Array(tweets).map { |tweet|
      new( id:   tweet.id,
           text: tweet.text,
           time: tweet.created_at,
           user: tweet.user.screen_name )
    }
  end

  include Twitter::Autolink

  def initialize(details)
    @id   = details.fetch(:id)
    @text = details.fetch(:text)
    @time = details.fetch(:time)
    @user = details.fetch(:user)
  end

  attr_reader :id, :text, :time, :user

  def url
    "https://twitter.com/#{user}/status/#{id}"
  end

  def linked_text
    auto_link(text)
  end
end
