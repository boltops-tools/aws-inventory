class Inventory::SecurityGroup
  class Unused < Inventory::Base
    include Shared

    def header
      ["Security Group Name"]
    end

    def data
      used_security_groups.map do |sg|
        sg.group_name
      end
    end
  end
end
