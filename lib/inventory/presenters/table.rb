require 'text-table'

class Inventory::Presenter::Table < Inventory::Presenter::Base
  def display
    table = Text::Table.new
    table.head = data.shift
    table.rows = data
    puts table
  end
end
