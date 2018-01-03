class Inventory::Ecs < Inventory::Base
  autoload :Service, "inventory/ecs/service"
  autoload :Cluster, "inventory/ecs/cluster"

  # Override report
  def report
    Service.new(@options).report
    Cluster.new(@options).report
  end
end
