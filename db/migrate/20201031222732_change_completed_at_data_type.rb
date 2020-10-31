class ChangeCompletedAtDataType < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :completed_at, :datetime, using 'completed_at::datetime'
  end
end
