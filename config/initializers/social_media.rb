module AOK
  SOCIAL_MEDIA_ACCOUNTS = Hash[ [
    { service:        "Facebook",
      url:            "https://www.facebook.com/OklahomaAtheists",
      call_to_action: "Join us on Facebook",
      css_class:      "s1" },
    { service:        "Twitter",
      url:            "https://twitter.com/AtheistOK",
      call_to_action: "Follow us on Twitter",
      css_class:      "s5" },
    { service:        "Google+",
      url:            "https://plus.google.com/u/0/communities/117866603268645374489",
      call_to_action: "Join our Social Circle",
      css_class:      "s9" },
    { service:        "YouTube",
      url:            "http://www.youtube.com/user/AtheistOK",
      call_to_action: "Watch Our Broadcasting",
      css_class:      "s7" }
  ].map { |account| [account[:service], SocialMediaAccount.new(account)] } ]
end
