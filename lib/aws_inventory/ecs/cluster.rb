class AwsInventory::Ecs::Cluster < AwsInventory::Base
  def header
    ["Cluster", "Container Instances", "Running Tasks"]
  end

  def data
    ecs_clusters.map do |cluster|
      [
        cluster.cluster_name,
        cluster.registered_container_instances_count,
        cluster.running_tasks_count,
      ]
    end
  end

  def ecs_clusters
    cluster_arns = ecs.list_clusters.cluster_arns
    @ecs_clusters ||= ecs.describe_clusters(clusters: cluster_arns).clusters
  end
end
