module TasksHelper

  def display_task_completed_at(task)
    if task.completed_at.nil?
      return "In Progress"
    else
      return task.completed_at.to_formatted_s(:twelvehr_long_ordinal)
    end
  end
end
