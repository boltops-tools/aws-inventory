# Inventory

AWS Inventory tool. Useful to get summarized information on AWS account.  The tool is produces tab separated output that can be pasted into a spreadsheet and then copied to a report.

## Usage

```sh
exe/inventory acm             # report acm inventory
exe/inventory cfn             # report cfn inventory
exe/inventory cw              # report cloudwatch inventory
exe/inventory eb              # report eb inventory
exe/inventory ec2             # report ec2 inventory
exe/inventory ecs             # report ecs inventory
exe/inventory elb             # report elb inventory
exe/inventory iam             # report iam inventory
exe/inventory keypair         # report keypair inventory
exe/inventory rds             # report rds inventory
exe/inventory route53         # report route53 inventory
exe/inventory sg              # report security group inventory
exe/inventory vpc             # report vpc inventory
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

### Format Option

There are 2 supported formats: tab and table.  The default is table.  To switch between formats use the INVENTORY_FORMAT environment variable.

```sh
export INVENTORY_FORMAT=tab
exe/inventory ec2
export INVENTORY_FORMAT=table
exe/inventory ec2
```
