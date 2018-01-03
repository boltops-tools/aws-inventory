class AwsInventory::Keypair < AwsInventory::Base
  def header
    ["Key Name", "Instance Count"]
  end

  def data
    key_pairs.map do |key|
      instance_count = instance_count(key)

      [key.key_name, instance_count]
    end
  end

  def sort(data)
    data.sort_by { |i| i[1] }.reverse
  end

  def key_pairs
    @key_pairs ||= ec2.describe_key_pairs.key_pairs
  end

  def instance_count(key)
    instances.count { |i| i.key_name == key.key_name }
  end
end
