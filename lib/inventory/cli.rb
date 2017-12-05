require "thor"
require "inventory/cli/help"

module Inventory

  class CLI < Command
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean

    desc "cfn", "report cfn inventory"
    long_desc Help.cfn
    def cfn
      Cfn.new(options).report
    end

  end
end
