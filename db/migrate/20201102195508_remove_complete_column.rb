class RemoveCompleteColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :complete
  end
end
