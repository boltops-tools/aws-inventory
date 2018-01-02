class Inventory::Presenter
  autoload :Base, "inventory/presenters/base"
  autoload :Tab, "inventory/presenters/tab"
  autoload :Table, "inventory/presenters/table"
  autoload :Json, "inventory/presenters/json"

  def initialize(data)
    @data = data
  end

  def display
    presenter_class = "Inventory::Presenter::#{format.classify}".constantize
    presenter = presenter_class.new(@data)
    presenter.display
  end

  # Formats: tabs, markdown
  def format
    ENV['AWS_INVENTORY_FORMAT'] || "table"
  end
end
