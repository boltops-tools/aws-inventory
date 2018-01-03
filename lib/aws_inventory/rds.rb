class Inventory::Rds < Inventory::Base
  autoload :Shared, "inventory/rds/shared"
  autoload :Summary, "inventory/rds/summary"
  autoload :Port, "inventory/rds/port"

  # Default is the open report because it seems like the most useful report
  def report
    Summary.new(@options).report if show(:summary)
    Port.new(@options).report if show(:port)
  end
end
