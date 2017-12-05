class Inventory::Cfn < Inventory::Base
  ALL_STATUSES = %w[
    REVIEW_IN_PROGRESS
    CREATE_FAILED
    UPDATE_ROLLBACK_FAILED
    UPDATE_ROLLBACK_IN_PROGRESS
    CREATE_IN_PROGRESS
    UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS
    ROLLBACK_IN_PROGRESS
    DELETE_COMPLETE
    UPDATE_COMPLETE
    UPDATE_IN_PROGRESS
    DELETE_FAILED
    DELETE_IN_PROGRESS
    ROLLBACK_COMPLETE
    ROLLBACK_FAILED
    UPDATE_COMPLETE_CLEANUP_IN_PROGRESS
    CREATE_COMPLETE
    UPDATE_ROLLBACK_COMPLETE
  ]
  ACTIVE_STATUSES = ALL_STATUSES - %w[DELETE_COMPLETE]

  def report
    results = []
    stack_summaries.each do |summary|
      results << [summary.stack_name, summary.template_description]
    end
    results.sort_by! {|a| a[0]}
    results.unshift(header)

    # print results
    results.each do |item|
      puts item.join("\t")
    end
  end

  def header
    ["Stack Name", "Description"]
  end

  def stack_summaries
    @stack_summaries ||= cfn.list_stacks(stack_status_filter: ACTIVE_STATUSES).stack_summaries
  end

  # unused right now but leaving around to later figure out how to integrate
  def text_table
    stack_summaries.each do |summary|
      table.rows << [summary.stack_name, summary.template_description]
    end

    table = Text::Table.new
    table.head = %w[Name Description]
    stack_summaries.each do |summary|
      table.rows << [summary.stack_name, summary.template_description]
    end
    puts table
  end
end
