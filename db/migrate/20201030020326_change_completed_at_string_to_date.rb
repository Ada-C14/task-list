class ChangeCompletedAtStringToDate < ActiveRecord::Migration[6.0]
  # def change
  #   change_column(:tasks, :completed_at, :datetime)
  # end
  def up
    change_column :tasks, :completed_at, 'date USING CAST(completed_at AS date)'
  end

  def down
    change_column :tasks, :completed_at, :string
  end
end
