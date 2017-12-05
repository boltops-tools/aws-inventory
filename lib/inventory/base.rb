class Inventory::Base
  include Inventory::AwsServices

  def initialize(options)
    @options = options
  end
end
