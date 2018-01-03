class AwsInventory::Eb < AwsInventory::Base
  def header
    ["Environment", "Application", "Solution Stack"]
  end

  def data
    eb_environments.map do |environment|
      [
        environment.environment_name,
        environment.application_name,
        environment.solution_stack_name,
      ]
    end
  end

  def eb_environments
    @eb_environments ||= eb.describe_environments.environments
  end
end
