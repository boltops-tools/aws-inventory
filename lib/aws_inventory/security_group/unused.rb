class AwsInventory::SecurityGroup
  class Unused < AwsInventory::Base
    include Shared

    def header
      ["Security Group Name", "Security Group Id"]
    end

    def data
      unused_security_groups.map do |sg|
        [
          sg.group_name,
          sg.group_id
        ]
      end
    end
  end
end
