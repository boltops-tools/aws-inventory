module AwsInventory::Rds::Shared
  # pretty name of vpc
  def vpc_name(db)
    group_ids = db.vpc_security_groups.map(&:vpc_security_group_id)
    resp = ec2.describe_security_groups(group_ids: group_ids)
    groups = resp.security_groups
    vpc_ids = groups.map(&:vpc_id)
    vpc_ids.map do |vpc_id|
      pretty_vpc_name = lookup_vpc_name(vpc_id)
      "#{vpc_id} (#{pretty_vpc_name})"
    end
  end

  def lookup_vpc_name(vpc_id)
    aws_inventory_vpc = AwsInventory::Vpc.new(@options)
    aws_inventory_vpc.vpc_name(vpc_id)
  end

  def vpcs
    @vpcs ||= ec2.describe_vpcs.vpcs
  end

  def pretty_vpc_security_group(db)
    groups = vpc_security_groups(db)
    groups.map { |g| "#{g.group_id} (#{g.group_name})" }
  end

  # pretty name of the vpc security groups
  def vpc_security_groups(db)
    group_ids = db.vpc_security_groups.map(&:vpc_security_group_id)
    group_ids.map do |db_security_group_id|
      security_groups.find {|sg| sg.group_id == db_security_group_id }
    end
  end

  def db_instances
    @db_instances ||= rds.describe_db_instances.db_instances
  end

  def security_group_names(instance)
    instance.security_groups.map {|sg| sg.group_name}.join(', ')
  end
end
