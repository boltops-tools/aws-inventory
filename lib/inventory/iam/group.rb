class Inventory::Iam
  class Group < Inventory::Base
    include Shared

    def header
      ["Group Name", "User Count", "User Names"]
    end

    def data
      data = [["(groupless)", groupless_users.size, groupless_users.join(', ')]]
      data += groups.map do |group|
        group_users = users_in_group(group.group_name)
        [
          group.group_name,
          group_users.size,
          group_users.join(', ')
        ]
      end
      data
    end
  end
end
