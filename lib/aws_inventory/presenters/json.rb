require "json"

class AwsInventory::Presenter::Json < AwsInventory::Presenter::Base
  def display
    json_data = {
      header: data.shift,
      data: data
    }
    puts JSON.pretty_generate(json_data)
  end
end
