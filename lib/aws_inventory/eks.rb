class AwsInventory::Eks < AwsInventory::Base
  autoload :Cluster, "aws_inventory/eks/cluster"
  autoload :Nodegroup, "aws_inventory/eks/nodegroup"

  # Override report
  def report
    Cluster.new(@options).report
    Nodegroup.new(@options).report

  end
end
