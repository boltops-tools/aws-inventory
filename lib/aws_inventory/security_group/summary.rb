class AwsInventory::SecurityGroup
  class Summary < AwsInventory::Base
    include Shared

    def header
      ["Security Group", "Count"]
    end

    def data
      [
        ["Total", security_groups.size],
        ["Used", used_security_groups.size],
        ["Unused", unused_security_groups.size],
      ]
    end
  end
end
