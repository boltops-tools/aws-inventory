class Inventory::SecurityGroup
  class Summary < Inventory::Base
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
