class AwsInventory::Iam < AwsInventory::Base
  autoload :Shared, "aws_inventory/iam/shared"
  autoload :Summary, "aws_inventory/iam/summary"
  autoload :User, "aws_inventory/iam/user"
  autoload :Group, "aws_inventory/iam/group"

  # Default is the groups report because it seems like the most useful report
  def report
    Summary.new(@options).report if show(:summary)
    User.new(@options).report if show(:users)
    Group.new(@options).report if show(:groups)
  end
end
