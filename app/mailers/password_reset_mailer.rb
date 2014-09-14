require 'mandrill'

class PasswordResetMailer < ActionMailer::Base

  def pw_reset_token(user)
    @user = user

    begin
      mandrill = Mandrill::API.new "#{ENV['MANDRILL_API_KEY']}"
      message = {
        "subject"=>"Password Reset Token",
        "from_email"=>"app21962348@heroku.com",
        "to"=>[{
          "name"=>"#{user.first_name} #{user.last_name}",
          "email"=>"#{user.email}",
          "type"=>"to"
        }],
        "html"=>"<p>Example HTML content</p>",
        "text"=>"Example text content"
      }
      result = mandrill.messages.send message
          # [{"reject_reason"=>"hard-bounce",
          #     "status"=>"sent",
          #     "_id"=>"abc123abc123abc123abc123abc123",
          #     "email"=>"recipient.email@example.com"}]
      
    rescue Mandrill::Error => e
        # Mandrill errors are thrown as exceptions
        puts "A mandrill error occurred: #{e.class} - #{e.message}"
        # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'    
        raise
    end
  end
end