require "json"

class Inventory::Presenter::Json < Inventory::Presenter::Base
  def display
    json_data = {
      header: @data.shift,
      data: @data
    }
    puts JSON.dump(json_data)
  end
end
