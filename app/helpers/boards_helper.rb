module BoardsHelper
  def board_members
    { "Officers"   => [
         BoardMember.new(
           name:     "Red McCall",
           position: "President",
           facebook: "https://www.facebook.com/red.mccall"
         ),
         BoardMember.new(
           name:     "Lindsey Box",
           position: "Vice President",
           facebook: "https://www.facebook.com/lindseybox"
         ),
         BoardMember.new(
           name:     "Michelle Ellis",
           position: "Secretary",
           facebook: "https://www.facebook.com/michellis7780"
         ),
         BoardMember.new(
           name:     "David Spitzer",
           position: "Treasurer",
           facebook: "https://www.facebook.com/dwspitzer"
         )
       ],
      "Chairs"     => [
         BoardMember.new(
           name:     "Nick Singer",
           position: "Activism Chair",
           facebook: "https://www.facebook.com/nasinger"
         ),
         BoardMember.new(
           name:     "Chris Garneau",
           position: "Education Chair",
           facebook: "https://www.facebook.com/chris.g22.2"
         ),
         BoardMember.new(
           name:     "Abe Haynes",
           position: "Outreach Coordinator",
           facebook: "https://www.facebook.com/abe.haynes"
         ),
         BoardMember.new(
           name:     "Chris Hollis",
           position: "Technology Chair",
           facebook: "https://www.facebook.com/cdhollis"
         )
      ],
      "Volunteers" => [
         BoardMember.new(
           name:     "Kate Fulghum",
           position: "Volunteer",
           facebook: "https://www.facebook.com/kmfulghum"
         ),
         BoardMember.new(
           name:     "Kristi Rowley",
           position: "Volunteer",
           facebook: "https://www.facebook.com/kristi.rowley.16"
         ),
         BoardMember.new(
           name:     "Marion Dilbeck",
           position: "Volunteer",
           facebook: "https://www.facebook.com/john.mergendeiler"
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
