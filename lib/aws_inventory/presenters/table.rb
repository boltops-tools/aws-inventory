require 'text-table'

class AwsInventory::Presenter::Table < AwsInventory::Presenter::Base
  def display
    table = Text::Table.new
    table.head = data.shift
    table.rows = data
    puts table
  end
end
