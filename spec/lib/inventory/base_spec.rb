require "spec_helper"

describe Inventory::Base do
  it "eager_load!" do
    Inventory::Base.eager_load!
  end
end
