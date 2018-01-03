class Inventory::Ecs < Inventory::Base
  autoload :Service, "aws_inventory/ecs/service"
  autoload :Cluster, "aws_inventory/ecs/cluster"

  # Override report
  def report
    Service.new(@options).report
    Cluster.new(@options).report
  end
end
