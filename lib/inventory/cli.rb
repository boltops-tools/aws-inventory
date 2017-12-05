require "thor"

module Inventory

  class CLI < Command
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean

    desc "cfn", "report cfn inventory"
    long_desc Help.text(:cfn)
    def cfn
      Cfn.new(options).report
    end

    desc "vpc", "report vpc inventory"
    long_desc Help.text(:vpc)
    def vpc
      Vpc.new(options).report
    end
  end
end
