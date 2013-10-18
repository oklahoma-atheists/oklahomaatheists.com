module HomeHelper
  def safer_videos(videos)
    count = 3
    if request.env["HTTP_USER_AGENT"] =~ %r{\bFirefox/(\d+)\b}i
      major_version = $1.to_i
      if major_version < 18
        count = 1
      end
    end
    @videos.first(count)
  end
end
