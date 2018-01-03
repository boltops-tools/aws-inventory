class AwsInventory::Presenter
  autoload :Base, "aws_inventory/presenters/base"
  autoload :Tab, "aws_inventory/presenters/tab"
  autoload :Table, "aws_inventory/presenters/table"
  autoload :Json, "aws_inventory/presenters/json"

  def initialize(options, data)
    @options = options
    @data = data
  end

  def display
    presenter_class = "AwsInventory::Presenter::#{format.classify}".constantize
    presenter = presenter_class.new(@options, @data)
    presenter.display
  end

  # Formats: tabs, markdown
  def format
    ENV['AWS_INVENTORY_FORMAT'] || "table"
  end
end
