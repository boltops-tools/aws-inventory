class Inventory::SecurityGroup < Inventory::Base
  def header
    ["Security Groups Summary:", ""]
  end

  def data
    [
      ["Total", security_groups.size],
      ["Used", used_security_groups.size],
      ["Unused", unused_security_groups.size],
    ]
  end

  # override sort to to control sort order
  def sort(data)
    data
  end

  def used_security_groups
    groups = instances.inject([]) do |results, i|
      results += i.security_groups
      results
    end
    groups.uniq(&:group_id)
  end

  def unused_security_groups
    used_group_ids = used_security_groups.map(&:group_id)
    security_groups.reject {|sg| used_group_ids.include?(sg.group_id) }
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
end
