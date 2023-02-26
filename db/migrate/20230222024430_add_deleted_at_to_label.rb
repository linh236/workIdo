class AddDeletedAtToLabel < ActiveRecord::Migration[7.0]
  def change
    add_column :labels, :deleted_at, :datetime
  end
end
