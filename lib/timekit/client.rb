# frozen_string_literal: true

require 'base64'

module Timekit
  class Client
    def initialize(app = nil, authorization = nil)
      @app = app || Timekit.config[:app]
      @authorization = authorization || Timekit.config[:credentials]

      raise 'No app configured' if @app.nil?
      raise 'No authorization configured' if @authorization.nil?
    end

    protected

    #
    # Wrapper method for the timekit request methods of the same names
    #
    %i[get put post delete].each do |verb|
      define_method(verb) do |path, params = {}|
        # puts "Timekit::Client::#{verb} => #{path}#{token}"
        headers = {
          'Timekit-App' => @app,
          'Authorization' => http_basic_auth_header
        }

        Timekit::Request.instance.send(
          __method__,
          path,
          params,
          headers
        )
      end
    end

    private

    def http_basic_auth_header
      encoded = Base64.strict_encode64(
        "#{@authorization.email}:#{@authorization.api_token}"
      )

      "Basic #{encoded}"
    end
  end
end
