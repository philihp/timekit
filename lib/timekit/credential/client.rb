# frozen_string_literal: true

module Timekit
  class Credential
    # Client class for the credential resource
    class Client < Timekit::Client
      API_PATH = '/credentials'

      def list
        get(API_PATH)
      end

      def create(
        type, # 'client-token' or 'server-token'
        scopes, # 'global' or 'widget'
        description,
        referrer = nil,
        expires = nil # default 1 year from now (timestamp)
      )
        params = {
          type: type,
          scopes: scopes,
          description: description
        }

        params[:referrer] = referrer if referrer
        params[:expires] = expires if expires

        post(API_PATH, params)
      end

      def delete(id)
        super(API_PATH + '/' + id.to_s)
      end
    end
  end
end
