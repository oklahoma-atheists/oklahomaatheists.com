class HomeController < ApplicationController
  def index
    @videos = Video.recent
    @events = Event.upcoming
  end
end
