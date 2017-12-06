module Inventory::Shared
  def instances
    return @instances if @instances

    @instances = []
    resp = ec2.describe_instances
    resp.reservations.each do |res|
      @instances += res.instances
    end
    @instances
  end

  def security_groups
    @security_groups ||= ec2.describe_security_groups.security_groups
  end
end
