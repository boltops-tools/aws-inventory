require "action_view"

class Inventory::Cloudwatch < Inventory::Base
  include ActionView::Helpers::DateHelper

  def header
    ["Alarm Name", "Threshold"]
  end

  def data
    alarms.map do |alarm|
      [
        alarm.alarm_name,
        threshold_desc(alarm)
      ]
    end
  end

  def threshold_desc(alarm)
    a = alarm
    total_period = a.period * a.evaluation_periods
    time_in_words = distance_of_time_in_words(total_period)
    "#{a.metric_name} #{compare_map[a.comparison_operator]} #{a.threshold} for #{a.evaluation_periods} datapoints within #{time_in_words}"
  end

  def compare_map
    {
      "GreaterThanOrEqualToThreshold" => ">=",
      "GreaterThanThreshold" => ">",
      "LessThanOrEqualToThreshold" => "<=",
      "LessThanThreshold" => "<",
    }
  end

  def alarms
    @alarms ||= cw.describe_alarms.metric_alarms
  end
end
