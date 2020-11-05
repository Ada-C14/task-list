class ChangeCompletedAtToDatetime < ActiveRecord::Migration[6.0]
  def change
    change_column(:tasks, :completed_at, 'timestamp USING CAST(completed_at AS timestamp)')
  end
end
