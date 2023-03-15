class AddMemberIdsToRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :member_ids, :json, default: []
  end
end
