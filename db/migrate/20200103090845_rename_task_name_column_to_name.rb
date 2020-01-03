class RenameTaskNameColumnToName < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :task_name, :name
  end
end
