class Inventory::SecurityGroup < Inventory::Base
  autoload :Shared, "inventory/security_group/shared"
  autoload :Summary, "inventory/security_group/summary"
  autoload :Open, "inventory/security_group/open"

  # Default is the open report because it seems like the most useful report
  def report
    Summary.new(@options).report if show(:summary)
    Open.new(@options).report if show(:open)
  end

  def show(report_type)
    ["all", report_type.to_s].include?(@options[:report_type])
  end
end
