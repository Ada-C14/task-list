module TasksHelper
    def safe_task_name(task)
        if task.name.empty?
            "Untitled Task"
        else
            task.name
        end
    end
end