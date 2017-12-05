# Child class must implement this interface.
# Methods:
#   header - header row to display.  Array of strings.
#   data - data to display under header. 2D Array.
#     Each item in the array represents a row of data.
class Inventory::Base
  include Inventory::AwsServices

  def initialize(options)
    @options = options
  end

  def report
    return if test_mode

    results = sort(data)
    results.unshift(header) if header
    results.each do |row|
      puts row.join("\t")
    end
  end

  def sort(data)
    data.sort_by {|a| a[0]}
  end

  def test_mode
    if ENV['TEST']
      puts "Testing #{self.class} report"
      true
    end
  end
end
