require "json"

class Inventory::Presenter::Json < Inventory::Presenter::Base
  def display
    json_data = {
      header: data.shift,
      data: data
    }
    puts JSON.pretty_generate(json_data)
  end
end
