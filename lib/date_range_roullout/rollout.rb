# frozen_string_literal: true

require "time"

module DateRangeRollout
  class Rollout
    def initialize(start_duration, start_date, end_duration, end_date)
      if start_date > end_date
        raise DateRangeError, "Start date should be before end date"
      end

      @start_duration = start_duration
      @start_date = start_date
      @end_duration = end_duration
      @end_date = end_date
    end

    def get
      now = Time.now

      if now <= @start_date
        return @start_duration.to_f
      end

      if now >= @end_date
        return @end_duration.to_f
      end

      offset = now.to_f - @start_date.to_f
      pct = offset / (@end_date.to_f - @start_date.to_f)

      pct * (@end_duration - @start_duration) + @start_duration
    end
  end
end
