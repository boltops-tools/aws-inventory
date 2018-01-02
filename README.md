# AWS Inventory

AWS Inventory tool. Useful to get summarized information on AWS account.  The tool by default produces a report that can easily be read from a terminal, but it can also be used produce a tab separated output report that can be pasted into a spreadsheet and then copied to a report.  This is controlled via a `AWS_INVENTORY_FORMAT` env variable and covered in the Format Options section.

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

What the output looks something like:

```sh
$ aws-inventory ec2
+-------+-------------+---------------+----------+-----------------+
| Name  | Instance Id | Instance Type | Platform | Security Groups |
+-------+-------------+---------------+----------+-----------------+
| name1 | i-123       | m3.medium     | linux    | sg-123          |
| name2 | i-456       | t2.small      | linux    | sg-456          |
+-------+-------------+---------------+----------+-----------------+
$
```

If you want to copy this to an spreadsheet, you can use the tab format.  Here's an example with `pbcopy`:

```sh
export AWS_INVENTORY_FORMAT=tab
aws-inventory ec2 | pbcopy
```

### To Check Every Region for EC2 Instances

```sh
GREEN='\033[0;32m'
NC='\033[0m' # No Color
for i in $(aws ec2 describe-regions | jq -r '.Regions[].RegionName') ; do
  echo -e "$GREEN$i$NC"
  AWS_REGION=$i aws-inventory ec2
done
```

### Format Option

There are a few supported formats: tab, table and json.  The default is table.  To switch between formats use the AWS_INVENTORY_FORMAT environment variable.

```sh
export AWS_INVENTORY_FORMAT=tab
aws-inventory ec2
export AWS_INVENTORY_FORMAT=table
aws-inventory ec2
export AWS_INVENTORY_FORMAT=json
aws-inventory ec2
```

## Install

```sh
gem install aws-inventory
```

## Contributing

I love pull requests! Happy to answer questions to help.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
