class Inventory::Presenter::Tab < Inventory::Presenter::Base
  def display
    data.each do |row|
      puts row.join("\t")
    end
  end
end
