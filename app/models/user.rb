class User < ApplicationRecord

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def refresh_token!
    #refreshing_token when user token is expired!!!!
    @response = HTTParty.post('https://accounts.google.com/o/oauth2/token', request_options)
    if @response.code == 200
      self.oauth_token = @response.parsed_response['access_token']
      self.oauth_expires_at = DateTime.now + @response.parsed_response['expires_in'].seconds
      self.save
    else
      Rails.logger.error("Unable to refresh google_oauth2 authentication token.")
      Rails.logger.error("Refresh token response body: #{@response.body}")
    end
  end

  def request_options
    #request_params for the refresh token method
    options = {
      body: {
        client_id: ENV["GOOGE_CLIENT_ID"],
        client_secret:  ENV["GOOGLE_CLIENT_SECRET"],
        refresh_token: self.refresh_token,
        grant_type: 'refresh_token'
      },
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
    }
  end
end
