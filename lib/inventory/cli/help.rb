module Inventory
  class CLI < Command
    class Help
      class << self
        def cfn
<<-EOL
Reports the cfn inventory
EOL
        end
      end
    end
  end
end
