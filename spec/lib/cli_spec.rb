require "spec_helper"

# to run specs with what"s remembered from vcr
#   $ rake
#
# to run specs with new fresh data from aws api calls
#   $ rake clean:vcr ; time rake
describe Inventory::CLI do
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
