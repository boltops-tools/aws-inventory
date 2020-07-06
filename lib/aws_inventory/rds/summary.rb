class AwsInventory::Rds
  class Summary < AwsInventory::Base
    include Shared

    def header
      ["DB Identifier", "Engine", "Instance Class", "Publicly Accessible", "VPC", "Security Groups"]
      #
    end

    def data
      db_instances.map do |db|
        [
          db.db_instance_identifier,
          "#{db.engine} #{db.engine_version}",
          db.db_instance_class,
          db.publicly_accessible ? "yes" : "no",
          vpc_name(db),
          pretty_vpc_security_group(db),
        ]
      end
    end
  end
end
