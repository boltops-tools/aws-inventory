class Inventory::Iam < Inventory::Base
  autoload :Shared, "inventory/iam/shared"
  autoload :Summary, "inventory/iam/summary"
  autoload :User, "inventory/iam/user"
  autoload :Group, "inventory/iam/group"

  # Default is the groups report because it seems like the most useful report
  def report
    Summary.new(@options).report if show(:summary)
    User.new(@options).report if show(:users)
    Group.new(@options).report if show(:groups)
  end

  def show(report_type)
    ["all", report_type.to_s].include?(@options[:report_type])
  end
end
