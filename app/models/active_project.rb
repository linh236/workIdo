class ActiveProject < ApplicationRecord
  belongs_to :project
  belongs_to :user

  scope :user_project, -> { where(user: Current.user)}

end
