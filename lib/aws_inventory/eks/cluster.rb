class AwsInventory::Eks::Cluster < AwsInventory::Base
  def header
    ["Cluster", "ARN", "Version", "Tags"]
  end

  def data
    eks_clusters.map do |cluster|
      [
        cluster.name,
        cluster.arn,
        "#{cluster.version} #{cluster.platform_version}",
        cluster.tags.to_s,
      ]
    end
  end

  def eks_clusters
    cluster_names = eks.list_clusters.clusters
    cluster_names.map do |cluster_name|
      eks.describe_cluster(name: cluster_name).cluster
    end
  end
end
