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
end
