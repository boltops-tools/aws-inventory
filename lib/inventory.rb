$:.unshift(File.expand_path("../", __FILE__))
require "inventory/version"

module Inventory
  autoload :Command, "inventory/command"
  autoload :CLI, "inventory/cli"
end
