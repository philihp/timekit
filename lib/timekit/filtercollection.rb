# frozen_string_literal: true

module Timekit
  class Filtercollection
    DAYS = %w[
      Monday
      Tuesday
      Wednesday
      Thursday
      Friday
      Saturday
      Sunday
    ].freeze

    def initialize
      @and_conditions = []
      @or_conditions = []
      @after_conditions = []
    end

    def as_json
      {
        or: @or_conditions,
        and: @and_conditions,
        after: @after_conditions
      }
    end

    def after_take_random(num)
      @after_conditions << { take_random: { number: num } }
    end

    def after_take_first(num)
      @after_conditions << { take_first: { number: num } }
    end

    def after_take_last(num)
      @after_conditions << { take_last: { number: num } }
    end

    def and_only_during_business_hours(timezone = nil)
      @and_conditions << { business_hours: timezone_param(timezone) }
    end

    def and_not_on_weekends(timezone = nil)
      @and_conditions << { exclude_weekends: timezone_param(timezone) }
    end

    def and_on_day(day)
      @and_conditions << specific_day(day)
    end

    def or_on_any_days(days)
      days.each { |day| @or_conditions << specific_day(day) }
    end

    def or_between_times(timestamp1, timestamp2)
      @or_conditions << {
        between_timestamps: {
          start: timestamp1,
          end: timestamp2
        }
      }
    end

    private

    def timezone_param(timezone)
      timezone ? { timezone: timezone } : {}
    end

    def specific_day(day)
      raise "Invalid day #{day}" unless DAYS.include?(day)
      { specific_day: { day: day } }
    end

    # def specific_day_and_time(day, start_time, end_time, timezone)
    #   raise "Invalid day #{day}" unless DAYS.include?(day)
    #
    #   {
    #     specific_day_and_time: {
    #       day: day,
    #       start: start_time,
    #       end: end_time
    #     }.merge!(timezone_param(timezone))
    #   }
    # end
  end
end
