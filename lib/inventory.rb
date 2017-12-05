$:.unshift(File.expand_path("../", __FILE__))
require "inventory/version"

require "pp"

module Inventory
  autoload :Command, "inventory/command"
  autoload :CLI, "inventory/cli"
  autoload :AwsServices, "inventory/aws_services"
  autoload :Cfn, "inventory/cfn"
end
