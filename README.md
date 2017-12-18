# AWS Inventory

AWS Inventory tool. Useful to get summarized information on AWS account.  The tool by default produces a reoprt that can easily be read from a terminal, but it can also be used produce a tab separated output report that can be pasted into a spreadsheet and then copied to a report.  This is controlled via a `AWS_INVENTORY_FORMAT` env variable and covered in the Format Options section.

## Usage

```sh
aws-inventory acm             # report acm inventory
aws-inventory cfn             # report cfn inventory
aws-inventory cw              # report cloudwatch inventory
aws-inventory eb              # report eb inventory
aws-inventory ec2             # report ec2 inventory
aws-inventory ecs             # report ecs inventory
aws-inventory elb             # report elb inventory
aws-inventory iam             # report iam inventory
aws-inventory keypair         # report keypair inventory
aws-inventory rds             # report rds inventory
aws-inventory route53         # report route53 inventory
aws-inventory sg              # report security group inventory
aws-inventory vpc             # report vpc inventory
```

## Example

What the output looks like:

```sh
$ aws-inventory ec2
Name  Instance Id Instance Type Security Groups
name1 i-123 t2.micro  sg1,sg2
name2  i-456 c3.2xlarge  s1
```

You want to pipe this into a tool like pbcopy so that tabs, not spaces are copied into your buffer.  Example:

```sh
$ aws-inventory ec2 | pbcopy
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

There are 2 supported formats: tab and table.  The default is table.  To switch between formats use the AWS_INVENTORY_FORMAT environment variable.

```sh
export AWS_INVENTORY_FORMAT=tab
aws-inventory ec2
export AWS_INVENTORY_FORMAT=table
aws-inventory ec2
```
