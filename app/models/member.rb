class Member < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :inviter, class_name: "User", foreign_key: "invited_by", optional: true
  # belongs_to :assign_members, class_name: "Label", foreign_key: "project", optional: true

  scope :member_accepted, -> { where(accept: true) }

  validates :user_id, uniqueness: { scope: :project_id }

  after_update :add_member_active_project

  def get_full_name
    self.user.full_name
  end

  private

    def add_member_active_project
    end

end
