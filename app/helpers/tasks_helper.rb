module TasksHelper
  def display_task_completed_at(completed_at)
    return completed_at ? "Completed: #{completed_at.to_formatted_s(:twelvehr_long_ordinal)}" : "In Progress"
  end

  def complete_button_text(completed_at)
    return completed_at ? "Mark In-Progress" : "Mark Complete"
  end

  def delete_confirm
    return {confirm: "Are you sure?"}
  end
end
