module AOK
  SOCIAL_MEDIA_ACCOUNTS = [
    { service:        "Facebook",
      url:            "https://www.facebook.com/OklahomaAtheists",
      call_to_action: "Join us on Facebook",
      css_class:      "s1" },
    { service:        "Twitter",
      url:            "https://twitter.com/AtheistOK",
      call_to_action: "Follow us on Twitter",
      css_class:      "s5" },
    { service:        "YouTube",
      url:            "http://www.youtube.com/user/AtheistOK",
      call_to_action: "Watch Our Broadcasting",
      css_class:      "s7" }
  ].map { |account| SocialMediaAccount.new(account) }
end
