class Event
  def self.upcoming
    events = AOK::APIs.meetup.fetch(
      :events,
      group_id: ENV.fetch("MEETUP_GROUP_ID"),
      status:   "upcoming"
    )
    Array(events).map { |event|
      new( name:      event.name,
           time:      event.time,
           attending: event.rsvpcount,
           url:       event.event_url,
           photo_url: event.photo_url )
    }
  end

  def initialize(details)
    @name      = details.fetch(:name)
    @time      = details.fetch(:time)
    @attending = details.fetch(:attending)
    @url       = details.fetch(:url)
    @photo_url = details.fetch(:photo_url)
  end

  attr_reader :name, :time, :attending, :url, :photo_url
end
