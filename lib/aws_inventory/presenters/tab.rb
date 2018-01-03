class AwsInventory::Presenter::Tab < AwsInventory::Presenter::Base
  def display
    data.each do |row|
      puts row.join("\t")
    end
  end
end
