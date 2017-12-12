module Inventory::Iam::Shared
  def group_names(user)
    groups = groups_for(user)
    groups.map(&:group_name)
  end

  @@groups = {}
  def groups_for(user)
    return @@groups[user.user_name] if @@groups[user.user_name]

    @@groups[user.user_name] = iam.list_groups_for_user(user_name: user.user_name).groups
  end

  # iam.list_groups does not show the users in the groups.
  # so users_in_groups returns an Array of the user_names in the specified group
  def users_in_group(group_name)
    # user_name is a String
    # group_names is an Array of Strings
    selected_users = all_users.select do |user_name, group_names|
        group_names.include?(group_name)
      end
    selected_users.map { |a| a[0] }
  end

  def groupless_users
    selected_users = all_users.select do |user_name, group_names|
        group_names.empty?
      end
      selected_users.map { |a| a[0] }
  end

  # {
  #   "tung": ["admin", "developers"],
  #   "vuon": ["admin"],
  #   "bob": ["developers"]
  # }
  def all_users
    @all_users ||= users.inject({}) do |result, user|
      result[user.user_name] = group_names(user)
      result
    end
  end

  def user_count(group)
    group_counts[group.group_name]
  end

  def user_names(group)
    users.each do |user|
      result[user.user_name] = group_names(user)
      result
    end
  end

  def users
    @users ||= iam.list_users.users
  end

  def groups
    @groups ||= iam.list_groups.groups
  end
end
