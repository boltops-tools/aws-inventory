class AwsInventory::Ecs::Service < AwsInventory::Base
  def header
    ["Service", "Cluster", "Running Tasks"]
  end

  def data
    ecs_services.map do |service|
      [
        service.service_name,
        cluster_name(service.cluster_arn),
        service.running_count,
      ]
    end
  end

  def cluster_name(cluster_arn)
    resp = ecs.describe_clusters(clusters: [cluster_arn]) # cluster takes name or ARN
    resp.clusters.first.cluster_name
  end

  def ecs_services
    cluster_arns = ecs.list_clusters.cluster_arns
    @ecs_services ||= cluster_arns.map do |cluster_arn|
        service_arns = ecs.list_services(cluster: cluster_arn).service_arns
        resp = ecs.describe_services(services: service_arns, cluster: cluster_arn)
        resp.services
      end.flatten
  end
end
