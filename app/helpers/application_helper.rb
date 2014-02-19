module ApplicationHelper
  HTML_ENTITIES_DECODER = HTMLEntities.new

  def icon(name)
    content_tag(:i, " ", class: "icon-#{name.to_s.tr('_', '-')}")
  end

  def nav_links
    [ NavLink.new( title:  "Home",
                   url:    root_path,
                   footer: true ),
      NavLink.new( title:  "Board",
                   url:    board_path ),
      NavLink.new( title:  "Blog",
                   url:    "http://blog.oklahomaatheists.com/",
                   footer: true ),
      NavLink.new( title:  "Events",
                   url:    "http://www.meetup.com/OklahomaAtheists/",
                   footer: true ) ]
  end

  def active_nav_link
    nav_links.reverse.find { |link|
      request.original_fullpath.start_with?(link.url)
    }
  end

  def friends
    [ FriendlyGroup.new( name: "Atheist Community of Tulsa",
                         url:  "http://actok.org/" ),
      FriendlyGroup.new( name: "Camp Quest Oklahoma",
                         url:  "http://campquestoklahoma.org/" ),
      FriendlyGroup.new( name: "FreeOK",
                         url:  "http://freeok.org/" ),
      FriendlyGroup.new( name: "Lawton Area Secular Society",
                         url:  "http://www.meetup.com/" +
                               "Lawton-Area-Secular-Society/" ),
      FriendlyGroup.new( name: "Norman Naturalism Group",
                         url:  "http://www.meetup.com/naturalism-6/" ),
      FriendlyGroup.new( name: "OKC Secular Parenting Group",
                         url:  "http://www.meetup.com/" +
                               "OKC-Secular-Parenting-Group/" ),
      FriendlyGroup.new( name: "Tinker Military Association of\n" +
                               "Atheists and Freethinkers",
                         url:  "http://www.meetup.com/tinkermaaf/" ) ]
  end

  def quotes
    [ Quote.new( comment: "I contend that we are both atheists.  " +
                          "I just believe in one fewer god than you do.",
                 by:      "Stephen Roberts" ),
      Quote.new( comment: "Facts do not cease to exist " +
                          "because they are ignored.",
                 by:      "Aldous Huxley" ),
      Quote.new( comment: "The invisible and the non-existent " +
                          "look very much alike.",
                 by:      "Delos McKown" ),
      Quote.new( comment: "Extraordinary claims require extraordinary evidence.",
                 by:      "Carl Sagan" ),
      Quote.new( comment: "A man's ethical behavior should be based " +
                          "effectually on sympathy, education, " +
                          "and social ties; no religious basis is necessary.",
                 by:      "Albert Einstein" ) ]
  end

  def html_unescape(text)
    HTML_ENTITIES_DECODER.decode(text)
  end
end
