module AwsInventory::SecurityGroup::Shared
  def used_security_groups
    groups = instances.inject([]) do |results, i|
      results += i.security_groups # returns Aws::EC2::Types::GroupIdentifier
      results
    end
    instance_groups = groups.uniq(&:group_id)

    v1_group_ids = elbv1.describe_load_balancers.load_balancer_descriptions.map(&:security_groups).flatten
    v2_group_ids = elbv2.describe_load_balancers.load_balancers.map(&:security_groups).flatten
    elb_group_ids = v1_group_ids + v2_group_ids
    elb_groups = security_groups.select { |sg| elb_group_ids.include?(sg.group_id) } # returns Aws::EC2::Types::SecurityGroup

    # Ducktyping: the types are different by they both respond to the group_id method.
    all_groups = instance_groups + elb_groups
    all_groups.uniq(&:group_id)
  end

  def unused_security_groups
    used_group_ids = used_security_groups.map(&:group_id)
    security_groups.reject {|sg| used_group_ids.include?(sg.group_id) }
  end
end
