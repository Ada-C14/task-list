class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :tasks, :completed, :completed_at
  end
end
