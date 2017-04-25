OmniAuth.config.logger = Rails.logger
OmniAuth.config.full_host = Rails.env.production? ? 'https://message-data-1.herokuapp.com/' : 'http://localhost:3000'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],
  {
    :scope => "profile, https://www.googleapis.com/auth/gmail.labels, https://www.googleapis.com/auth/gmail.readonly",
    :prompt => "select_account"
  }
end