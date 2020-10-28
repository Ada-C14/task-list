class AddCompletedAtToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :completed_at, :string
  end
end
