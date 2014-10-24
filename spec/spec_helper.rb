require 'rspec'
require_relative '../lib/saucer'
require 'vcr'
require 'approvals/rspec'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<SAUCE_LABS_PASSWORD>') { Env.sauce_labs_password }
  c.filter_sensitive_data('<SAUCE_LABS_EMAIL>')    { Env.sauce_labs_email }
end

RSpec.configure do |c|
  c.approvals_path = 'spec/fixtures/approvals/'
end
