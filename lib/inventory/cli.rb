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

    desc "ec2", "report ec2 inventory"
    long_desc Help.text(:ec2)
    def ec2
      Ec2.new(options).report
    end

    desc "vpc", "report vpc inventory"
    long_desc Help.text(:vpc)
    def vpc
      Vpc.new(options).report
    end

    desc "sg", "report security group inventory"
    long_desc Help.text(:sg)
    def sg
      SecurityGroup.new(options).report
    end

    desc "rds", "report rds inventory"
    long_desc Help.text(:rds)
    def rds
      Rds.new(options).report
    end
  end
end
