class RenameCompletedAtToCompleteBy < ActiveRecord::Migration[6.0]
  def change
    rename_column :tasks, :completed_at, :complete_by
  end
end
