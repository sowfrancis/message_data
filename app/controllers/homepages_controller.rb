class HomepagesController < ApplicationController

  def index
    if current_user
      gmail_request
    end
  end



  private

  #request for fetching message from google API
  def gmail_request
    current_user.refresh_token! if current_user.oauth_expires_at < Time.now
    user_oauth = current_user.oauth_token
    service = Google::Apis::GmailV1::GmailService.new
    service.authorization = user_oauth
    @messages = service.list_user_messages('me', max_results: 10, label_ids:["CATEGORY_PERSONAL", "INBOX"])
    @messages_parse = @messages.messages.map {|message| service.get_user_message('me', message.id)}
  end

end
