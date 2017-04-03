# frozen_string_literal: true

module Timekit
  class Event
    # Client class for the event resource
    class Client < Timekit::Client
      API_PATH = '/events'

      def list(start_datetime, end_datetime)
        params = {
          start: start_datetime,
          end: end_datetime
        }

        get(API_PATH, params)
      end

      def show(id)
        get(API_PATH + '/' + id.to_s)
      end

      def create(
        event_start,
        event_end,
        what,
        where,
        calendar_id,
        participants = nil,
        invite = nil,
        description = nil,
        sync_provider = nil,
        my_rsvp = nil,
        all_day = nil
      )

        params = {
          start: event_start,
          end: event_end,
          what: what,
          where: where,
          calendar_id: calendar_id
        }

        params = set_optional_params(
          binding,
          %i[
            participants
            invite
            description
            my_rsvp
            sync_provider
            all_day
          ],
          params
        )

        post(API_PATH, params)
      end

      def update(
        id,
        event_start = nil,
        event_end = nil,
        what = nil,
        where = nil,
        participants = nil,
        all_day = nil
      )
        params = {}
        params[:start] = event_start if event_start
        params[:end] = event_end if event_end

        params = set_optional_params(
          binding,
          %i[
            what
            where
            participants
            all_day
          ],
          params
        )

        put(API_PATH + '/' + id.to_s, params)
      end

      def delete(id)
        super(API_PATH + '/' + id.to_s)
      end

      private

      def set_optional_params(binding, optional_params, params)
        optional_params.each do |name|
          value = binding.local_variable_get(name)
          params[name.to_sym] = value if
            [true, false].include?(value) || !value.nil?
        end

        params
      end
    end
  end
end
