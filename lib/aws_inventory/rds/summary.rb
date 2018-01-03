class AwsInventory::Rds
  class Summary < AwsInventory::Base
    include Shared

    def header
      ["Name", "Engine", "Instance Class", "Publicly Accessible", "VPC", "Security Groups"]
      #
    end

    def data
      db_instances.map do |db|
        [
          db.db_name,
          db.engine,
          db.db_instance_class,
          db.publicly_accessible ? "yes" : "no",
          vpc_name(db),
          pretty_vpc_security_group(db),
        ]
      end
    end
  end
end
