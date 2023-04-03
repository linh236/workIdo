class AddIsPrivateToMeeting < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :is_private, :boolean, default: false
  end
end
