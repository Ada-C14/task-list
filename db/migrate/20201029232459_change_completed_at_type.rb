class ChangeCompletedAtType < ActiveRecord::Migration[6.0]
  def change
    remove_column(:tasks, :completed_at)
    add_column(:tasks, :completed_at, :datetime)
  end
end
