class AccountNotificationsController < ApplicationController
  before_action :set_account_notifications, only: %i[mark_read]
  def index
    @pagy, @account_notifications = pagy(AccountNotification.where(user: current_user).order(created_at: :desc), items: 10)
    # @account_notifications.last.activity.object_activity_type
  end

  def mark_read
    if @account_notification.update(mark_read: true)
    else
    end
  end
  
  private 

    def set_account_notifications
      @account_notification = AccountNotification.find(params[:id])
    end
end
