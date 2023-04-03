class AddMemberIdsToMeeting < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :member_ids, :json, deafult: []
  end
end
