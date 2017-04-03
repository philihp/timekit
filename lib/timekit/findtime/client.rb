# frozen_string_literal: true

module Timekit
  class Findtime
    # Client class for the findtime resource
    class Client < Timekit::Client
      API_PATH = '/findtime'

      def query(
        emails = nil,
        user_ids = nil,
        calendar_ids = nil,
        filters = {},
        filtercollection_id = nil,
        start = nil,
        future = '2 days',
        length = '1 hour',
        sort = 'asc',
        ignore_all_day_events = false,
        all_solutions = false
      )
        params = {}

        # All args are optional, so we can examine each arg and
        # set it as a key in the params hash if a value exists for the arg
        method(__method__).parameters.map do |_, name|
          value = binding.local_variable_get(name)
          params[name.to_sym] = value if [true, false].include?(value) ||
                                         !value.nil?
        end

        unless params[:emails] || params[:user_ids] || params[:calendar_ids]
          raise 'Entity id required to find time'\
            ' (email,user id,calendar id)'
        end

        post(API_PATH, params)
      end

      def bulk_query(queries); end
    end
  end
end
