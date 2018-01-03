class Inventory::Route53 < Inventory::Base
  def header
    ["Domain", "Record Set Count"]
  end

  def data
    zones.map do |zone|
      record_sets = resource_record_sets(zone)
      [zone.name, record_sets.count]
    end
  end

  def records
    zones.inject([]) do |array, zone|
      array << resource_record_sets(zone)
    end
  end

  @@resource_record_sets = {}
  def resource_record_sets(zone)
    @@resource_record_sets[zone.id] ||= route53
      .list_resource_record_sets(hosted_zone_id: zone.id)
      .resource_record_sets
  end

  def zones
    @zones ||= route53.list_hosted_zones.hosted_zones
  end
end
