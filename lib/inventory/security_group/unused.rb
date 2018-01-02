class Inventory::SecurityGroup
  class Unused < Inventory::Base
    include Shared

    def header
      ["Security Group Name", "VPC Id"]
    end

    def data
      unused_security_groups.map do |sg|
        [
          sg.group_name,
          sg.vpc_id
        ]
      end
    end
  end
end
