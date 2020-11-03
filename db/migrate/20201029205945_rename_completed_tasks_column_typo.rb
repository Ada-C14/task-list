class RenameCompletedTasksColumnTypo < ActiveRecord::Migration[6.0]
  def change
    rename_column :tasks, :comppleted_at, :completed_at
  end
end
