class AccountNotification < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :user
  belongs_to :activity

  scope :notification_count, -> { where( user: Current.user, mark_read: false ) }

  after_create_commit do
    broadcast_update_to("notifications", partial: "layouts/shared/count_notification", locals: { notification_count: AccountNotification.notification_count.size }, target: "notification-count")
  end
end
