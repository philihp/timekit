# frozen_string_literal: true

require_relative './user/client'

module Timekit
  # this class is used for User creation
  class User
    # this hits a public endpoint, no authorization required
    def self.create(
      email,
      timezone,
      first_name,
      last_name = nil,
      password = nil
    )

      params = {
        email: email,
        timezone: timezone,
        first_name: first_name
      }
      params[:last_name] = last_name if last_name
      params[:password] = password if password

      Timekit::Request.instance.send(
        :post,
        "#{Timekit.config[:api_endpoint]}#{Timekit::User::Client::API_PATH}",
        params,
        'Timekit-App' => Timekit.config[:app]
      )
    end

    def self.auth(email, password)
      params = {
        email: email,
        password: password
      }

      Timekit::Request.instance.send(
        :post,
        "#{Timekit.config[:api_endpoint]}/auth",
        params,
        'Timekit-App' => Timekit.config[:app]
      )
    end
  end
end
