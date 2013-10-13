class ContactsController < ApplicationController
  def create
    ContactMailer.get_in_touch( params[:name],
                                params[:email],
                                params[:message] ).deliver
    render nothing: true
  end
end
