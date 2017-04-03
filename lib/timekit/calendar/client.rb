# frozen_string_literal: true

module Timekit
  class Calendar
    # Client class for the calendar resource
    class Client < Timekit::Client
      API_PATH = '/calendars'

      def create(
        name,
        description,
        background_color = nil,
        foreground_color = nil
      )
        params = {
          name: name,
          description: description
        }

        params[:backgroundcolor] = background_color if background_color
        params[:foregroundcolor] = foreground_color if foreground_color

        post(API_PATH, params)
      end

      def list
        get(API_PATH)
      end

      def show(id)
        get(API_PATH + '/' + id.to_s)
      end

      def delete(id)
        super(API_PATH + '/' + id.to_s)
      end
    end
  end
end
