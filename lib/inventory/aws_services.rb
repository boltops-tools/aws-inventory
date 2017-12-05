require 'aws-sdk'

module Inventory::AwsServices
  def cfn
    @cfn ||= Aws::CloudFormation::Client.new
  end

  def ec2
    @ec2 ||= Aws::EC2::Client.new
  end

  def pricing
    @pricing ||= Aws::Pricing::Client.new
  end

  def rds
    @rds ||= Aws::RDS::Client.new
  end

  def route53
    @route53 ||= Aws::Route53::Client.new
  end

  def acm
    @acm ||= Aws::ACM::Client.new
  end
end
