require "spec_helper"

describe AwsInventory::Base do
  it "eager_load!" do
    AwsInventory::Base.eager_load!
  end
end
