class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_current_user, :projects, :current_project, :notifications

  include Pagy::Backend

  def projects 
    @projects ||= ActiveProject.user_project
  end

  def current_project
    active_project = ActiveProject.where(user: current_user, active: true).first
    @current_project = active_project.project rescue nil
  end

  def set_current_user
    Current.user = current_user
    Current.project = current_project
  end

  def notifications 
    @notification_count = AccountNotification.notification_count.size
  end

  def render_success message
    render turbo_stream: turbo_stream.append(
      'toast',
      partial: 'shared/toast_success',
      locals: {
        message: message
      }
    )
  end

  def render_danger message
    render turbo_stream: turbo_stream.append(
      'toast',
      partial: 'shared/toast_danger',
      locals: {
        message: message
      }
    )
  end

  def render_warning message
    render turbo_stream: turbo_stream.append(
      'toast',
      partial: 'shared/toast_warning',
      locals: {
        message: message
      }
    )
  end
  
  def tracking_activity class_name, detail
    if class_name.instance_of? String 
      class_object = class_name
    else
      class_object = class_name.class.name
    end
    Activity.create(activity_type: class_object, perform_id: Current.user.id, detail: detail)
  end

  def tracking_notification user_ids, activity_id
    params = []
    user_ids.each do |user_id|
      params << { user_id: user_id, activity_id: activity_id, mark_read: false }
    end
    AccountNotification.create(params)
  end

  def object_activity_type type
    @object = type.constantize
  end

end
