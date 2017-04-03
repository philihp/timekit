# frozen_string_literal: true

require 'simplecov'
require 'coveralls'
SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/vendor/'
  minimum_coverage(99.57)
end

require 'date'
require 'singleton'
require 'rest-client'
require 'faker'
require 'timekit'
require 'rspec'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow: 'coveralls.io')

RSpec.configure do |config|
  config.before(:suite) do
    Timekit.configure(
      app: 'testapp',
      email: 'test@example.com',
      api_token: 'testapitoken'
    )
  end
end

def a_delete(path)
  a_request(:delete, Timekit::Request::BASE_URL + path)
end

def a_get(path)
  with_default_options(
    a_request(:get, Timekit::Request::BASE_URL + path)
  )
end

def a_post(path)
  a_request(:post, Timekit::Request::BASE_URL + path)
end

def a_put(path)
  a_request(:put, Timekit::Request::BASE_URL + path)
end

def stub_delete(path)
  stub_request(:delete, Timekit::Request::BASE_URL + path)
end

def stub_get(path)
  with_default_options(
    stub_request(:get, Timekit::Request::BASE_URL + path)
  )
end

def stub_post(path)
  stub_request(:post, Timekit::Request::BASE_URL + path)
end

def stub_put(path)
  stub_request(:put, Timekit::Request::BASE_URL + path)
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def with_default_options(request)
  request.with(
    basic_auth: [
      Timekit.config[:credentials].email,
      Timekit.config[:credentials].api_token
    ],
    headers: {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'Timekit-App' => Timekit.config[:app]
    }
  )
end

# class ActiveSupport::TestCase
#   # Setup all fixtures in test/fixtures/*.yml
#   # for all tests in alphabetical order.
#   fixtures :all
#
#   # Add more helper methods to be used by all tests here...
# end
