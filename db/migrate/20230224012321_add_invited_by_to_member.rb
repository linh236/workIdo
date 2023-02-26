class AddInvitedByToMember < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :invited_by, :integer
  end
end
