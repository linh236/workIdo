class AddMarkReadToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :mark_read, :json, default: []
  end
end
