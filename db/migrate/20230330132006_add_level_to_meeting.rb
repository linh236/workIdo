class AddLevelToMeeting < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :level, :string
  end
end
