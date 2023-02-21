class AddSelectedToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :selected, :boolean
  end
end
