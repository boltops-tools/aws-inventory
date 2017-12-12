Reports the IAM inventory.

List of groups and users in the groups:

$ inventory iam --report-type groups # this is the default

$ inventory iam  # same as above

List of the users and their groups:

$ inventory iam --report-type users

Summary of number of groups and users

$ inventory iam --report-type summary
