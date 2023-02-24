class AddPriorityToLabel < ActiveRecord::Migration[7.0]
  def change
    add_column :labels, :priority, :integer
  end
end
