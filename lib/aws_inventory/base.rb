# Child class must implement this interface.
# Methods:
#   header - header row to display.  Array of strings.
#   data - data to display under header. 2D Array.
#     Each item in the array represents a row of data.
class AwsInventory::Base
  include AwsInventory::AwsServices

  def initialize(options)
    @options = options
  end

  def report
    return if test_mode

    results = sort(data)
    results.unshift(header) if header
    presenter = AwsInventory::Presenter.new(@options, results)
    presenter.display
  end

  def sort(data)
    data.sort_by {|a| a[0]}
  end

  def test_mode
    if ENV['TEST']
      puts "Testing #{self.class} report" # specs tests against this
      true
    end
  end

  def show(report)
    ["all", report.to_s].include?(@options[:report])
  end

  class << self
    # Track all command subclasses.
    def subclasses
      @subclasses ||= []
    end

    def inherited(base)
      super

      if base.name
        self.subclasses << base
      end
    end

    # Thought this might be useful for
    # specs. Eager load all classes so then we can loop thorugh the
    # methods and run specs on any new cli commands.
    # The rspec code turn out a too ugly to follow though. Leaving this
    # around in case eager_laod is useful for other purposes
    def eager_load!
      path = File.expand_path("../", __FILE__)

      Dir.glob("#{path}/**/*.rb").select do |path|
        next if !File.file?(path) or path =~ /version/

        class_name = path
                      .sub('.rb','')
                      .sub(%r{.*/aws_inventory}, 'aws_inventory')
                      .camelize
        # special rules
        class_name.sub!("Cli", "CLI")
                  .sub!('Presenters', 'Presenter')

        class_name.constantize # use constantize instead of require
          # so we dont have to worry about require order.
      end
    end
  end
end
