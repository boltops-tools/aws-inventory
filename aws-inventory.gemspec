# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "aws_inventory/version"

Gem::Specification.new do |spec|
  spec.name          = "aws-inventory"
  spec.version       = AwsInventory::VERSION
  spec.authors       = ["Tung Nguyen"]
  spec.email         = ["tongueroo@gmail.com"]
  spec.description   = %q{Tool to inventory AWS account}
  spec.summary       = %q{Tool to inventory AWS account}
  spec.homepage      = "https://github.com/tongueroo/aws-inventory"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "hashie"
  spec.add_dependency "colorize"
  spec.add_dependency "aws-sdk-cloudformation"
  spec.add_dependency "aws-sdk-ec2"
  spec.add_dependency "aws-sdk-pricing"
  spec.add_dependency "aws-sdk-rds"
  spec.add_dependency "aws-sdk-route53"
  spec.add_dependency "aws-sdk-acm"
  spec.add_dependency "aws-sdk-elasticloadbalancing"
  spec.add_dependency "aws-sdk-elasticloadbalancingv2"
  spec.add_dependency "aws-sdk-elasticbeanstalk"
  spec.add_dependency "aws-sdk-ecs"
  spec.add_dependency "aws-sdk-iam"
  spec.add_dependency "aws-sdk-elasticbeanstalk"
  spec.add_dependency "activesupport"
  spec.add_dependency "text-table"
  spec.add_dependency "facets"
  spec.add_dependency "actionview"
  spec.add_dependency "json"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "guard-rspec"
end
