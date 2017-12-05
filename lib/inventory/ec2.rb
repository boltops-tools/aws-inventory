class Inventory::Ec2 < Inventory::Base
  def header
    ["Name", "Instance Id", "Instance Type", "Security Groups"]
  end

  def data
    data = []
    instances.each do |i|
      tags = i.tags
      name_tag = tags.find { |t| t.key == "Name" }
      name = name_tag.value if name_tag
      group_names = security_group_names(i)
      row = [name, i.instance_id, i.instance_type, group_names]
      data << row
    end
    data
  end

  def security_group_names(instance)
    instance.security_groups.map {|sg| sg.group_name}.join(', ')
  end

  def security_groups
    @security_groups ||= ec2.describe_security_groups.security_groups
  end

  def instances
    return @instances if @instances

    @instances = []
    resp = ec2.describe_instances
    resp.reservations.each do |res|
      @instances += res.instances
    end
    @instances
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
