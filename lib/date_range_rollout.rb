# frozen_string_literal: true

require "date_range_rollout/version"
require "date_range_rollout/rollout"

module DateRangeRollout
  class Error < StandardError; end
  class DateRangeError < Error; end

  def self.build(start_duration, start_date, end_duration, end_date)
    Rollout.new(start_duration, start_date, end_duration, end_date)
  end
end
