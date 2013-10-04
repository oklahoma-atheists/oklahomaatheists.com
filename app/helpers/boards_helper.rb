module BoardsHelper
  def board_members
    { "Officers"   => [
         BoardMember.new(
           name:     "Red McCall",
           position: "President",
           facebook: "https://www.facebook.com/red.mccall"
         ),
         BoardMember.new(
           name:     "Paul Dawson",
           position: "Vice President",
           facebook: "https://www.facebook.com/paul.dawson.180"
         ),
         BoardMember.new(
           name:     "Casey Wilmot",
           position: "Secretary",
           facebook: "https://www.facebook.com/Mixato"
         ),
         BoardMember.new(
           name:     "EJ Klapperich",
           position: "Treasurer",
           facebook: "https://www.facebook.com/ejklapperichjr"
         )
       ],
      "Chairs"     => [
         BoardMember.new(
           name:     "Chas Stewart",
           position: "Activism Chair",
           facebook: "https://www.facebook.com/chas.stewart"
         ),
         BoardMember.new(
           name:     "Clayton Flesher",
           position: "Education Chair",
           facebook: "https://www.facebook.com/clayton.flesher"
         ),
         BoardMember.new(
           name:     "Michelle Ellis",
           position: "Outreach Coordinator",
           facebook: "https://www.facebook.com/michellis7780"
         ),
         BoardMember.new(
           name:     "James Edward Gray II",
           position: "Technology Chair",
           facebook: "https://www.facebook.com/james.gray.9022662",
           twitter:  "https://twitter.com/JEG2"
         )
      ],
      "Volunteers" => [
         BoardMember.new(
           name:     "Lindsey Box",
           position: "Volunteer",
           facebook: "https://www.facebook.com/lindseybox"
         ),
         BoardMember.new(
           name:     "Eric Levine",
           position: "Volunteer",
           facebook: "https://www.facebook.com/ericplvn"
         ),
         BoardMember.new(
           name:     "Lennon Patton",
           position: "Volunteer",
           facebook: "https://www.facebook.com/lennon.patton"
         )
      ] }
  end

  def headshot(member)
    image = "#{member.name.downcase.tr(' ', '_')}.png"
    if File.exist?( File.join( File.dirname(__FILE__),
                               *(%w[.. assets images] + [image])) )
      image_tag(image, alt: member.name)
    end
  end

  def link_to_social_media(service, member)
    if (url = member.send(service))
      link_to icon(service), url
    end
  end
end
