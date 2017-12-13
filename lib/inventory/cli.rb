module Inventory
  class CLI < Command
    class_option :verbose, type: :boolean

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
    option :report_type, default: "open", desc: "all, summary, or open"
    def sg
      SecurityGroup.new(options).report
    end

    desc "rds", "report rds inventory"
    long_desc Help.text(:rds)
    option :report_type, default: "summary", desc: "all, summary, or port"
    def rds
      Rds.new(options).report
    end

    desc "route53", "report route53 inventory"
    long_desc Help.text(:route53)
    def route53
      Route53.new(options).report
    end

    desc "acm", "report acm inventory"
    long_desc Help.text(:acm)
    def acm
      Acm.new(options).report
    end

    desc "elb", "report elb inventory"
    long_desc Help.text(:elb)
    def elb
      Elb.new(options).report
    end

    desc "eb", "report eb inventory"
    long_desc Help.text(:eb)
    def eb
      Eb.new(options).report
    end

    desc "ecs", "report ecs inventory"
    long_desc Help.text(:ecs)
    def ecs
      Ecs.new(options).report
    end

    desc "keypair", "report keypair inventory"
    long_desc Help.text(:keypair)
    def keypair
      Keypair.new(options).report
    end

    desc "iam", "report iam inventory"
    long_desc Help.text(:iam)
    option :report_type, default: "groups", desc: "all, groups, users, or summary"
    def iam
      Iam.new(options).report
    end

    desc "cw", "report cloudwatch inventory"
    long_desc Help.text(:cw)
    def cw
      Cloudwatch.new(options).report
    end
  end
end
