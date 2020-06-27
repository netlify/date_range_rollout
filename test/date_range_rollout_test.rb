require "test_helper"

class DateRangeRolloutTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil DateRangeRollout::VERSION
  end

  def test_outside_bounds
    start_date = Time.parse("2020-03-10")
    end_date = Time.parse("2020-03-20")
    drr = DateRangeRollout.build(10.0, start_date, 50.0, end_date)

    assert_equal 10.0, Timecop.freeze(Time.parse("2020-03-09")) { drr.get }
    assert_equal 10.0, Timecop.freeze(Time.parse("2020-03-10")) { drr.get }

    assert_equal 50.0, Timecop.freeze(Time.parse("2020-03-20")) { drr.get }
    assert_equal 50.0, Timecop.freeze(Time.parse("2020-03-21")) { drr.get }
  end

  def test_inside_bounds
    start_date = Time.parse("2020-03-10")
    end_date = Time.parse("2020-03-20")
    drr = DateRangeRollout.build(10.0, start_date, 50.0, end_date)

    assert_equal 14.0, Timecop.freeze(Time.parse("2020-03-11")) { drr.get }
    assert_equal 30.0, Timecop.freeze(Time.parse("2020-03-15")) { drr.get }
    assert_equal 46.0, Timecop.freeze(Time.parse("2020-03-19")) { drr.get }
  end

  def test_reverse_range
    start_date = Time.parse("2020-03-10")
    end_date = Time.parse("2020-03-20")
    drr = DateRangeRollout.build(50.0, start_date, 10.0, end_date)

    assert_equal 46.0, Timecop.freeze(Time.parse("2020-03-11")) { drr.get }
    assert_equal 30.0, Timecop.freeze(Time.parse("2020-03-15")) { drr.get }
    assert_equal 14.0, Timecop.freeze(Time.parse("2020-03-19")) { drr.get }
  end

  def test_bad_dates
    assert_raises DateRangeRollout::DateRangeError do
      DateRangeRollout.build(10.0, Time.parse("2020-03-20"), 50.0, Time.parse("2020-03-10"))
    end
  end
end
