class Inventory::Vpc < Inventory::Base
  def header
    ["Name", "Vpc ID", "CIDR", "Subnets", "Instances"]
  end

  def data
    data = []
    vpcs.each do |vpc|
      tag = vpc.tags.find {|t| t.key == "Name"}
      name = tag ? tag.value : "(unnamed)"
      subnets = subnets_for(vpc)
      instances = instances_in(subnets)
      data << [name, vpc.vpc_id, vpc.cidr_block, subnets.count, instances.count]
    end
    data
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

  def instances
    return @instances if @instances

    @instances = []
    resp = ec2.describe_instances
    resp.reservations.each do |res|
      @instances += res.instances
    end
    @instances
  end
end
