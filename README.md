# Inventory

AWS Inventory tool. Useful to get summarized information on an client's AWS account for a Cloud Assessment report.

## Usage

```sh
exe/inventory ec2
exe/inventory cfn
exe/inventory sg
exe/inventory vpc
exe/inventory help
```

## Example

```sh
$ exe/inventory ec2
Name  Instance Id Instance Type Security Groups
name1 i-123 t2.micro  sg1,sg2
name2  i-456 c3.2xlarge  s1
```
