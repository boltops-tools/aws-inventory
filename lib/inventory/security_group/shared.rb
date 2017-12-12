module Inventory::SecurityGroup::Shared
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
end
