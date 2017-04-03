# frozen_string_literal: true

require 'singleton'
require 'rest-client'

module Timekit
  # class for executing http requests against timekit api
  class Request
    include Singleton

    BASE_URL = 'https://api.timekit.io/v2'

    %i[get put post delete].each do |verb|
      define_method(verb) do |path, params, headers|
        request __method__, path, params, headers
      end
    end

    private

    def request(verb, path, params, headers)
      headers = headers.merge!(http_headers)

      # puts "Timekit::Request::request #{verb},"\
      # " #{BASE_URL}#{path}, #{params}, #{headers}"
      RestClient::Request.execute(
        method: verb.downcase.to_sym,
        url: BASE_URL + path,
        payload: params ? params.to_json : nil,
        headers: headers
      )
    end

    def http_headers
      {
        content_type: 'application/json',
        accept: 'application/json'
      }
    end
  end
end
