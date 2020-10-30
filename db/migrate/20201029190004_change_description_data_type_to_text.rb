class ChangeDescriptionDataTypeToText < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :description, :text
  end
end
