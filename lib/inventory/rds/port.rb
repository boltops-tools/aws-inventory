class Inventory::Rds
  class Port < Inventory::Base
    include Shared

    def header
      ["RDS Db Name", "Security Group", "Range/Source", "Port"]
    end

    def data
      data = []
      db_instances.each do |db|
        db_security_groups = vpc_security_groups(db)
        db_security_groups.each do |sg|

          sg.ip_permissions.each do |permission|
            data << [
              db.db_name,
              "#{sg.group_id} (#{sg.group_name})",
              ip_range_and_source(permission),
              port(permission)
            ]
          end

        end
      end
      data
    end

    def port(permission)
      ports = [permission.from_port, permission.to_port].uniq
      if ports.size > 1
        raise "TODO: account for port ranges"
      else
        ports.first
      end
    end

    def ip_range_and_source(permission)
      cidr_ips = permission.ip_ranges.map {|range| range.cidr_ip }
      user_id_group_pairs = permission.user_id_group_pairs.map do |pair|
        # pair.group_name is always returning nil :( Might be AWS bug
        # so fetching it from security groups themselves
        sg = security_groups.find {|sg| sg.group_id == pair.group_id }
        sg_name = " (#{sg.group_name})" if sg

        "#{pair.group_id}#{sg_name}" # pretty format
      end
      result = cidr_ips + user_id_group_pairs
      result.join(', ')
    end

  end
end
