require "spec_helper"

describe AwsInventory::CLI do
  before(:all) do
    @args = ""
  end

  %w[
    acm
    cfn
    cw
    eb
    ec2
    ecs
    elb
    help
    iam
    keypair
    rds
    route53
    sg
    vpc
  ].each do |command|
    it command do
      out = execute("exe/aws-inventory #{command} #{@args}")
      expect(out).to include("report")
    end
  end
end
