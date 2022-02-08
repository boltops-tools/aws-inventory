class AwsInventory::Eks::Nodegroup < AwsInventory::Base
  def header
    ["Cluster", "Nodegroup", "Version", "Capacity Type", "Scaling Config", "Node Role", "Labels", "Tags"]
  end

  def data
    eks_nodegroups.map do |nodegroup|
      [
        nodegroup.cluster_name,
        nodegroup.nodegroup_name,
        "#{nodegroup.version} #{nodegroup.release_version}",
        nodegroup.capacity_type,
        nodegroup.scaling_config.to_s,
        nodegroup.node_role,
        nodegroup.labels.to_s,
        nodegroup.tags.to_s,
      ]
    end
  end

  def eks_nodegroups
    cluster_names = eks.list_clusters.clusters
    cluster_names.map do |cluster_name|
      nodegroups = eks.list_nodegroups(cluster_name: cluster_name).nodegroups
      nodegroups.map do |nodegroup|
        resp = eks.describe_nodegroup(cluster_name: cluster_name, nodegroup_name:nodegroup)
        resp.nodegroup
      end.flatten
    end.flatten
  end
end
