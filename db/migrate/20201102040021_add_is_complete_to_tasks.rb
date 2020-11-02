class AddIsCompleteToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :is_complete, :boolean
  end
end
