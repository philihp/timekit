# frozen_string_literal: true

module Timekit
  class App
    # Client class for the app resource
    class Client < Timekit::Client
      API_PATH = '/apps'

      def list
        get(API_PATH)
      end

      def create(name, settings = {})
        params = {
          name: name
        }

        params[:settings] = settings if settings

        post(API_PATH, params)
      end

      def update(slug, settings)
        params = settings

        put(API_PATH + '/' + slug, params)
      end

      def delete(slug)
        super(API_PATH + '/' + slug)
      end
    end
  end
end
