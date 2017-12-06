$:.unshift(File.expand_path("../", __FILE__))
require "inventory/version"
require "text-table"
require "active_support/all"
require "pp"

module Inventory
  autoload :Base, "inventory/base"
  autoload :Help, "inventory/help"
  autoload :Command, "inventory/command"
  autoload :CLI, "inventory/cli"
  autoload :AwsServices, "inventory/aws_services"
  autoload :Shared, "inventory/shared"
  autoload :Cfn, "inventory/cfn"
  autoload :Ec2, "inventory/ec2"
  autoload :Vpc, "inventory/vpc"
  autoload :SecurityGroup, "inventory/security_group"
  autoload :Rds, "inventory/rds"
  autoload :Route53, "inventory/route53"
  autoload :Acm, "inventory/acm"
  autoload :Elb, "inventory/elb"
end
