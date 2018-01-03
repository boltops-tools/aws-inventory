class Inventory::Presenter::Base
  def initialize(options, data)
    @options = options
    @data = data
  end

  def data
    @options[:header] ? @data : @data[1..-1]  # remove the header row
  end
end
