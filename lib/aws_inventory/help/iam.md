Reports the IAM inventory.

List of groups and users in the groups:

$ aws-inventory iam --report groups # this is the default

$ aws-inventory iam  # same as above

List of the users and their groups:

$ aws-inventory iam --report users

Summary of number of groups and users

$ aws-inventory iam --report summary
