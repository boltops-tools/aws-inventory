class Inventory::Iam < Inventory::Base
  autoload :Shared, "inventory/iam/shared"
  autoload :Summary, "inventory/iam/summary"
  autoload :User, "inventory/iam/user"
  autoload :Group, "inventory/iam/group"

  # Default is the groups report because it seems like the most useful report
  def report
    Summary.new(@options).report if show_summary
    User.new(@options).report if show_users
    Group.new(@options).report if show_groups
  end

  def show_summary
    %w[all summary].include?(@options[:report_type])
  end

  def show_users
    %w[all users].include?(@options[:report_type])
  end

  def show_groups
    %w[all groups].include?(@options[:report_type])
  end
end
