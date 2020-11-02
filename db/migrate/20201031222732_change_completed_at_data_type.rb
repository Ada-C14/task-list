class ChangeCompletedAtDataType < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :completed_at, "timestamp USING completed_at::timestamp without time zone"
  end
end
