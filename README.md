# Inventory

AWS Inventory tool. Useful to get summarized information on AWS account.  The tool is produces tab separated output that can be pasted into a spreadsheet and then copied to a report.

## Usage

```sh
exe/inventory cfn
exe/inventory ec2
exe/inventory vpc
exe/inventory sg
exe/inventory rds
exe/inventory route53
exe/inventory acm
exe/inventory elb
exe/inventory eb
exe/inventory ecs
```

## Example

What the output looks like:

```sh
$ exe/inventory ec2
Name  Instance Id Instance Type Security Groups
name1 i-123 t2.micro  sg1,sg2
name2  i-456 c3.2xlarge  s1
```

You want to pipe this into a tool like pbcopy so that tabs, not spaces are copied into your buffer.  Example:

```sh
$ exe/inventory ec2 | pbcopy
```

### To Check Every Region for EC2 Instances

```sh
GREEN='\033[0;32m'
NC='\033[0m' # No Color
for i in $(aws ec2 describe-regions | jq -r '.Regions[].RegionName') ; do
  echo -e "$GREEN$i$NC"
  AWS_REGION=$i inventory ec2
done
```
