# frozen_string_literal: true

module Timekit
  class Findtime
    class Filtercollections
      # Client class for the filtercollection resource
      class Client < Timekit::Client
        API_PATH = '/findtime/filtercollections'

        def create(
          and_conditions = nil,
          or_conditions = nil,
          after_conditions = nil
        )
          params = {
            and: and_conditions,
            or: or_conditions,
            after: after_conditions
          }

          post(API_PATH, params)
        end

        def show(id)
          get(API_PATH + '/' + id.to_s)
        end
      end
    end
  end
end
