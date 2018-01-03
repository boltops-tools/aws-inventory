require "spec_helper"

describe Inventory::SecurityGroup::Open do
  let(:reporter) { Inventory::SecurityGroup::Open.new({}) }

  it "combine_ports" do
    ports = [22]
    combined_ports = reporter.combine_ports(ports)
    expect(combined_ports).to eq([22])

    ports = [80, 443]
    combined_ports = reporter.combine_ports(ports)
    expect(combined_ports).to eq([80, 443])

    ports = [80, 8000..8001]
    combined_ports = reporter.combine_ports(ports)
    expect(combined_ports).to eq([80, 8000..8001])

    ports = [1..5, 3..8]
    combined_ports = reporter.combine_ports(ports)
    expect(combined_ports).to eq([1..8])

    ports = [80, 22, 443]
    combined_ports = reporter.combine_ports(ports)
    expect(combined_ports).to eq([22, 80, 443])

    ports = [8001, 8000..8002]
    combined_ports = reporter.combine_ports(ports)
    expect(combined_ports).to eq([8000..8002])
  end
end
