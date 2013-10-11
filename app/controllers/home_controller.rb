class HomeController < ApplicationController
  def index
    loader.start_loading(:videos)   { Video.recent   }
    loader.start_loading(:events)   { Event.upcoming }
    loader.start_loading(:products) { Product.all    }
  end
end
