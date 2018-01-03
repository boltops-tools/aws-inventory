class Inventory::Vpc < Inventory::Base
  def header
    ["Name", "Vpc ID", "CIDR", "Subnets", "Instances"]
  end

  def data
    vpcs.map do |vpc|
      subnets = subnets_for(vpc)
      instances = instances_in(subnets)

      [
        vpc_name(vpc.vpc_id),
        vpc.vpc_id,
        vpc.cidr_block,
        subnets.count,
        instances.count
      ]
    end
  end

  # Pretty vpc name
  # Use vpc_id as argument so other classes can use this method also
  def vpc_name(vpc_id)
    vpc = vpcs.find { |vpc| vpc.vpc_id == vpc_id }
    tag = vpc.tags.find {|t| t.key == "Name"}
    name = tag ? tag.value : "(unnamed)"
  end

  def vpcs
    @vpcs ||= ec2.describe_vpcs.vpcs
  end

  def subnets_for(vpc)
    ec2.describe_subnets(
      filters: [
        {
          name: "vpc-id",
          values: [
            vpc.vpc_id,
          ],
        },
    ]).subnets
  end

  def instances_in(subnets)
    subnet_ids = subnets.map(&:subnet_id)
    instances.select do |i|
      subnet_ids.include?(i.subnet_id)
    end
  end

  def subnets
    @subnets ||= ec2.describe_subnets.subnets
  end
end
