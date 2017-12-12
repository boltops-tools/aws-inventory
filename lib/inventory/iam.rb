class Inventory::Iam < Inventory::Base
  autoload :Shared, "inventory/iam/shared"
  autoload :User, "inventory/iam/user"
  autoload :Group, "inventory/iam/group"

  # Default is the groups report because it is a useful summary
  def report
    User.new(@options).report if show_users
    Group.new(@options).report if show_groups
  end

  def show_users
    %w[all users].include?(@options[:report_type])
  end

  def show_groups
    %w[all groups].include?(@options[:report_type])
  end
end
