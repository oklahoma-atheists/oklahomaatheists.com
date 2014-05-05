class ContactsController < ApplicationController
  def create
    unless params[:subject] =~ /\S/
      ContactMailer.get_in_touch( params[:name],
                                  params[:email],
                                  params[:message] ).deliver
    end
    render nothing: true
  end
end
