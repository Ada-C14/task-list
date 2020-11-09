class ChangeCompleteAtToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :completed_at, :text
  end
end
