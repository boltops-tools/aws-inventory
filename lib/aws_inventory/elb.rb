class Inventory::Elb < Inventory::Base
  def header
    ["ELB", "Type", "Security Group", "Open Ports"]
  end

  def data
    data = []
    elbs.each do |lb|
      # lb.security_groups is actualy a list of group_ids
      lb.security_groups.each do |group_id|
        security_group_name = security_group_name(group_id) # weird: sometimes sg doesnt exist
        open_ports = open_ports(group_id)

        data << [
          lb.load_balancer_name,
          lb_type(lb),
          security_group_name,
          open_ports]
      end
    end

    data
  end

  def lb_type(lb)
    lb.respond_to?(:type) ? lb.type : 'classic'
  end

  def elbs
    application_load_balancers + classic_load_balancers
  end

  # override custom sort
  def sort(data)
    data
  end

  def classic_load_balancers
    @classic_load_balancers ||= elbv1.describe_load_balancers.load_balancer_descriptions
  end

  def security_group_names(lb)
    # lb.security_groups is actualy a list of group_ids
    lb.security_groups.map do |group_id|
      security_group_name(group_id)
    end.join(', ')
  end

  # Somehow sometimes there can be an ELB with a security group that does
  # not actually exist.  In the AWS Console it says:
  #  "There was an error loading the Security Groups."
  def security_group_name(group_id)
    security_group = security_groups.find { |sg| sg.group_id == group_id }
    group_name = security_group ? security_group.group_name : "not found"
    "#{group_id} (#{group_name})"
  end

  def application_load_balancers
    @application_load_balancers ||= elbv2.describe_load_balancers.load_balancers
  end

  # Returns an Array of ports with a cidr of 0.0.0.0/0
  # Delegates to Inventory::SecurityGroup
  def open_ports(group_id)
    sg = security_groups.find { |sg| sg.group_id == group_id }
    return unless sg

    aws_inventory = Inventory::SecurityGroup::Open.new(@options)
    aws_inventory.ports_open_to_world(sg)
  end
end
