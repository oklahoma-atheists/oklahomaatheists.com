class ContactMailer < ActionMailer::Base
  def get_in_touch(name, email, message)
    @message = message

    mail to:       AOK::EMAIL,
         from:     "#{name} <#{email}>",
         subject:  "A Comment From the AOK Site"
  end
end
