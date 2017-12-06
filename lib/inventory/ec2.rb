class Inventory::Ec2 < Inventory::Base
  def header
    ["Name", "Instance Id", "Instance Type", "Security Groups"]
  end

  def data
    instances.map do |i|
      tags = i.tags
      name_tag = tags.find { |t| t.key == "Name" }
      name = name_tag.value if name_tag
      group_names = security_group_names(i)

      [name, i.instance_id, i.instance_type, group_names]
    end
  end

  def security_group_names(instance)
    instance.security_groups.map {|sg| sg.group_name}.join(', ')
  end

  # Currently dont have access to the pricing api so skipping
  # def describe_pricing
  #   resp = pricing.describe_services(
  #     format_version: "aws_v1",
  #     max_results: 1,
  #     service_code: "AmazonEC2",
  #   )
  #   pp resp
  # end
end
