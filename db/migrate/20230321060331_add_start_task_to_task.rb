class AddStartTaskToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :start_task, :datetime
    add_column :tasks, :end_task, :datetime
  end
end
