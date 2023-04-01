class Meeting < ApplicationRecord
  has_rich_text :description
  enum levels: [:highest, :high, :medium, :low]

  belongs_to :user
  belongs_to :project

  def tags
    if self.member_ids.present? && self.member_ids.include?(Current.user.id)
      return true
    else
      return false
    end
  end

  def self.share_with
    share_with = []
    share_with << Project.new(id: 0, name: "Only me")
    share_with << ActiveProject.where(user: Current.user, active: true).first.project
    share_with
  end
end
