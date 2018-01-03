class Inventory::Rds < Inventory::Base
  autoload :Shared, "aws_inventory/rds/shared"
  autoload :Summary, "aws_inventory/rds/summary"
  autoload :Port, "aws_inventory/rds/port"

  # Default is the open report because it seems like the most useful report
  def report
    Summary.new(@options).report if show(:summary)
    Port.new(@options).report if show(:port)
  end
end
