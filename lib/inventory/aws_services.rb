require 'aws-sdk'

module Inventory::AwsServices
  include Inventory::Shared

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

  def elbv1
    @elbv1 ||= Aws::ElasticLoadBalancing::Client.new
  end

  def elbv2
    @elbv2 ||= Aws::ElasticLoadBalancingV2::Client.new
  end

  def eb
    @eb ||= Aws::ElasticBeanstalk::Client.new
  end

  def ecs
    @ecs ||= Aws::ECS::Client.new
  end

  def iam
    @iam ||= Aws::IAM::Client.new
  end

  def cw
    @cw ||= Aws::CloudWatch::Client.new
  end
end
