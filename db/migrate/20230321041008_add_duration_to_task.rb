class AddDurationToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :duration, :integer
  end
end
