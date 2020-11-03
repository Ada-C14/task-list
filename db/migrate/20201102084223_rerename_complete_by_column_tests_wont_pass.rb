class RerenameCompleteByColumnTestsWontPass < ActiveRecord::Migration[6.0]
  def change
    rename_column :tasks, :complete_by, :completed_at
  end
end
