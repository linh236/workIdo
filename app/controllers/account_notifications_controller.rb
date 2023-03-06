class AccountNotificationsController < ApplicationController
  def index
    @pagy, @account_notifications = pagy(AccountNotification.where(user: current_user).order(created_at: :desc))
    # @account_notifications.last.activity.object_activity_type
  end
end
