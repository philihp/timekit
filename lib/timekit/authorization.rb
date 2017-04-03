# frozen_string_literal: true

module Timekit
  class Authorization
    attr_reader :email, :api_token

    def initialize(email, api_token)
      @email = email
      @api_token = api_token
    end

    def as_json
      {
        email: @email,
        api_token: @api_token
      }
    end
  end
end
