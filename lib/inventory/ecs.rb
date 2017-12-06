class Inventory::Ecs
  autoload :Service, "inventory/ecs/service"
  autoload :Cluster, "inventory/ecs/cluster"

  def initialize(options)
    @options = options
  end

  def report
    Service.new(@options).report
    Cluster.new(@options).report
  end
end
