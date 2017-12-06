class Inventory::Elb < Inventory::Base
  def header
    ["Domain", "Cert Arn", "Type"]
  end

  def data
    app_elbs = application_load_balancers.map do |lb|
      [
        lb.load_balancer_name,
        security_group_names(lb),
        "Application ELB"
      ]
    end

    classic_elbs = classic_load_balancers.map do |lb|
      [
        lb.load_balancer_name,
        security_group_names(lb),
        "Classic ELB"
      ]
    end

    app_elbs + classic_elbs
  end

  # override custom sort
  def sort(data)
    data
  end

  def classic_load_balancers
    @classic_load_balancers ||= elbv1.describe_load_balancers.load_balancer_descriptions
  end

  def security_group_names(lb)
    lb.security_groups.map do |group_id|
      security_group = security_groups.find { |sg| sg.group_id == group_id }
      # Somehow sometimes there can be an ELB with a security group that does
      # not actually exist.  In the AWS Console it says:
      #  "There was an error loading the Security Groups."
      group_name = security_group ? security_group.group_name : "not found"
      "#{group_id} (#{group_name})"
    end.join(', ')
  end

  def application_load_balancers
    @application_load_balancers ||= elbv2.describe_load_balancers.load_balancers
  end
end
