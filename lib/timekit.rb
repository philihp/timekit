# frozen_string_literal: true

require_relative './timekit/config'
require_relative './timekit/client'
require_relative './timekit/authorization'
require_relative './timekit/user'
require_relative './timekit/credential'
require_relative './timekit/app'
require_relative './timekit/calendar'
require_relative './timekit/event'
require_relative './timekit/request'
require_relative './timekit/findtime'
require_relative './timekit/filtercollection'
require_relative './timekit/widget'
require_relative './timekit/booking'

# Timekit class is responsible for handling configurations
# and provides helpers for instantiating clients for apis
module Timekit
  @config = Timekit::Config.new

  def self.config
    @config
  end

  def self.configure(configurations)
    config[:app] = configurations[:app] if configurations[:app]

    email = configurations[:email]
    token = configurations[:api_token]
    return unless email && token

    config[:credentials] = Timekit::Authorization.new(
      email, token
    )
  end

  def self.calendar_client
    Timekit::Calendar::Client.new(config[:app], config[:credentials])
  end

  def self.app_client
    Timekit::App::Client.new(config[:app], config[:credentials])
  end

  def self.credential_client
    Timekit::Credential::Client.new(config[:app], config[:credentials])
  end

  def self.event_client
    Timekit::Event::Client.new(config[:app], config[:credentials])
  end

  def self.user_client
    Timekit::User::Client.new(config[:app], config[:credentials])
  end

  def self.findtime_client
    Timekit::Findtime::Client.new(config[:app], config[:credentials])
  end

  def self.widget_client
    Timekit::Widget::Client.new(config[:app], config[:credentials])
  end

  def self.booking_client
    Timekit::Booking::Client.new(config[:app], config[:credentials])
  end
end
