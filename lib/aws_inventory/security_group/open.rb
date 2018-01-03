require 'facets/array/arrange'

class Inventory::SecurityGroup
  class Open < Inventory::Base
    include Shared

    def header
      ["Security Group", "Open to World"]
    end

    def data
      opened_security_groups_in_use = opened_security_groups.select do |sg|
        group_ids_in_use = used_security_groups.map(&:group_id)
        group_ids_in_use.include?(sg.group_id)
      end

      # Only display used security groups that have opened ports for review.
      # will delete the unused security groups anyway.
      opened_security_groups_in_use.map do |sg|
        ports = ports_open_to_world(sg)
        [
          sg.group_name,
          ports
        ]
      end
    end

    def opened_security_groups
      security_groups.select do |sg|
        ports = ports_open_to_world(sg)
        !ports.empty?
      end
    end

    # Returns an Array of ports with a cidr of 0.0.0.0/0
    def ports_open_to_world(sg)
      ip_permissions = sg.ip_permissions.select do |permission|
          permission.ip_ranges.detect do |ip_range|
            ip_range.include?('0.0.0.0/0')
          end
        end

      ports = ip_permissions.map do |p|
        if p.from_port == p.to_port
          p.from_port
        else
          (p.from_port..p.to_port)
        end
      end

      ports = combine_ports(ports)
      # convert to string for printing
      ports.map(&:to_s).join(', ')
    end

    # Examples
    #
    # Input:
    #    ports: [80, 443]
    # Output:
    #    ports: [80, 443
    #
    # Input:
    #    ports: [8001, 8000..8002]
    # Output:
    #    ports: [8000..8002]
    def combine_ports(port_objects)
      ports = port_objects.inject([]) do |array, port|
        ports = port.is_a?(Range) ? port.to_a : [port]
        array += ports
        array
      end.uniq
      ports.arrange
    end
  end
end
