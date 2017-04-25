require 'omniauth'
require 'httparty'

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

OmniAuth.config.test_mode = true

omniauth_hash = {
  'provider' => 'GOOGLE',
  'uid' => '123545',
  'user_info' => {
    'name' => 'mockuser'
  },
  'credentials' => {
    'token' => '1234567890',
    'expires_at' => 160000,
    'refresh_token' => 'mock_refresh_token'
  }
}

 OmniAuth.config.add_mock(:google, omniauth_hash)