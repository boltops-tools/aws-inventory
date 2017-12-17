class Inventory::Presenter
  autoload :Base, "inventory/presenters/base"
  autoload :Tab, "inventory/presenters/tab"
  autoload :Table, "inventory/presenters/table"

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
    ENV['INVENTORY_FORMAT'] || "table"
  end
end
