class AccountNotification < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  scope :notification_count, -> { where( user: Current.user, mark_read: false ) }

end
