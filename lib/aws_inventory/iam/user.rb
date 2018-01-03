class Inventory::Iam
  class User < Inventory::Base
    include Shared

    def header
      ["User", "Password Last Used"]
    end

    def data
      users.map do |user|
        group_names = group_names(user).join(',')

        [user.user_name, group_names]
      end
    end

    def sort(data)
      data.sort_by { |item| item[1].to_i }.reverse
    end
  end
end
