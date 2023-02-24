class AddDeletedAtToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :deleted_at, :datetime
  end
end
