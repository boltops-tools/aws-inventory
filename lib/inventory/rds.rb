class Inventory::Rds < Inventory::Base
  def header
    ["Name", "Engine", "Instance Class", "Publicly Accessible", "VPC", "Security Groups"]
    #
  end

  def data
    db_instances.map do |db|
      [
        db.db_name,
        db.engine,
        db.db_instance_class,
        db.publicly_accessible ? "yes" : "no",
        vpc_name(db),
        vpc_security_groups(db),
      ]
    end
  end

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
    inventory_vpc = Inventory::Vpc.new(@options)
    inventory_vpc.vpc_name(vpc_id)
  end

  def vpcs
    @vpcs ||= ec2.describe_vpcs.vpcs
  end

  # pretty name of the vpc security groups
  def vpc_security_groups(db)
    group_ids = db.vpc_security_groups.map(&:vpc_security_group_id)
    group_ids.map do |db_security_group_id|
      group = security_groups.find {|sg| sg.group_id == db_security_group_id }
      "#{db_security_group_id} (#{group.group_name})"
    end
  end

  def db_instances
    @db_instances ||= rds.describe_db_instances.db_instances
  end

  def security_group_names(instance)
    instance.security_groups.map {|sg| sg.group_name}.join(', ')
  end
end
