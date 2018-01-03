class Inventory::Ec2 < Inventory::Base
  def header
    ["Name", "Instance Id", "Instance Type", "Platform", "Security Groups"]
  end

  def data
    instances.map do |i|
      name = name_from_tag(i)
      group_names = security_group_names(i)

      [
        name,
        i.instance_id,
        i.instance_type,
        platform(i), # windows or linux
        group_names,
      ]
    end
  end

  def name_from_tag(instance)
    tags = instance.tags
    name_tag = tags.find { |t| t.key == "Name" }
    name_tag ? name_tag.value : "(unnamed)"
  end

  def security_group_names(instance)
    instance.security_groups.map {|sg| sg.group_name}.join(', ')
  end

  def cost(instance)
    cost_type = COST_MAP[instance.instance_type]
    if cost_type
      cost = cost_type[platform(instance)]
      cost.round(2)
    end
  end

  def platform(instance)
    instance.platform || "linux"
  end
end
