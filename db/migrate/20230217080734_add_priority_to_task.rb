class AddPriorityToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :priority, :integer, unique: true
  end
end
