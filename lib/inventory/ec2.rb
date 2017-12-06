class Inventory::Ec2 < Inventory::Base
  def header
    ["Name", "Instance Id", "Instance Type", "Platform", "Security Groups"]
  end

  def data
    instances.map do |i|
      name = name_from_tag(i)
      group_names = security_group_names(i)
      # cost = cost(i)

      [
        name,
        i.instance_id,
        i.instance_type,
        # cost,
        platform(i), # windows or linux
        group_names,
      ]
    end
  end

  def name_from_tag(instance)
    tags = instance.tags
    name_tag = tags.find { |t| t.key == "Name" }
    name_tag ? name_tag.value : "(unnamed)"
  end

  def security_group_names(instance)
    instance.security_groups.map {|sg| sg.group_name}.join(', ')
  end

  def cost(instance)
    cost_type = COST_MAP[instance.instance_type]
    if cost_type
      cost = cost_type[platform(instance)]
      cost.round(2)
    end
  end

  def platform(instance)
    instance.platform || "linux"
  end

  # hardcode pricing info until access to pricing api is sorted out
  # these costs are per month.
  COST_MAP = {
    "t2.micro" => {
      "windows" => 11.826,
      "linux" => 8.468,
    },
    "t2.medium" => {
      "windows" => 47.012,
      "linux" => 33.872,
    },
    "t2.large" => {
      "windows" => 88.184,
      "linux" => 67.744,
    },
    "r3.4xlarge" => {
      "windows" => 1419.12,
      "linux" => 970.9,
    },
    "m4.large" => {
      "windows" => 140.16,
      "linux" => 73.0,
    },
    "m4.2xlarge" => {
      "windows" => 560.64,
      "linux" => 292,
    },
    "c3.2xlarge" => {
      "windows" => 548.96,
      "linux" => 306.6,
    },
  }
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
