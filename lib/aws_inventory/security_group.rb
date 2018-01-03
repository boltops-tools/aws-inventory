class Inventory::SecurityGroup < Inventory::Base
  autoload :Shared, "aws_inventory/security_group/shared"
  autoload :Summary, "aws_inventory/security_group/summary"
  autoload :Open, "aws_inventory/security_group/open"
  autoload :Unused, "aws_inventory/security_group/unused"

  # Default is the open report because it seems like the most useful report
  def report
    Summary.new(@options).report if show(:summary)
    Open.new(@options).report if show(:open)
    Unused.new(@options).report if show(:unused)
  end
end
