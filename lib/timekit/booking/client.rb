# frozen_string_literal: true

module Timekit
  class Booking
    # Client class for the booking resource
    class Client < Timekit::Client
      API_PATH = '/bookings'

      def list
        get(API_PATH)
      end

      def show(id)
        get(API_PATH + '/' + id)
      end

      def create(
        graph,
        event,
        customer,
        action = nil
      )
        params = {
          graph: graph,
          event: event,
          customer: customer
        }

        params[:action] = action if action

        post(API_PATH, params)
      end

      def update(
        id,
        action
      )
        put(API_PATH + '/' + id + '/' + action)
      end
    end
  end
end
