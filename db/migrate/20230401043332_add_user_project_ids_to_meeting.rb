class AddUserProjectIdsToMeeting < ActiveRecord::Migration[7.0]
  def change
    add_reference :meetings, :user, null: false, foreign_key: true
    add_reference :meetings, :project, null: false, foregin_key: true
  end
end
