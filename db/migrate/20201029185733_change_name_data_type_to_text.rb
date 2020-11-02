class ChangeNameDataTypeToText < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :name, :text
  end
end
