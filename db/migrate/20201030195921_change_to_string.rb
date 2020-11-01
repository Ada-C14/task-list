class ChangeToString < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :completed_at, :string
  end
end
