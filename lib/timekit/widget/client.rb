# frozen_string_literal: true

module Timekit
  class Widget
    # Client class for the widget resource
    class Client < Timekit::Client
      API_PATH = '/widgets'

      def list
        get(API_PATH)
      end

      def embed(id)
        get(API_PATH + '/embed/' + id.to_s)
      end

      def hosted(slug)
        get(API_PATH + '/hosted/' + slug)
      end

      def update(
        id,
        config,
        name = nil,
        slug = nil
      )
        params = {
          config: config
        }

        params[:name] = name if name
        params[:slug] = slug if slug

        put(API_PATH + '/' + id.to_s, params)
      end

      def create(
        config,
        name,
        slug
      )
        params = {
          config: config,
          name: name,
          slug: slug
        }

        post(API_PATH, params)
      end

      def delete(id)
        super(API_PATH + '/' + id.to_s)
      end
    end
  end
end
