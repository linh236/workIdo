class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
  def tracking_activity class_name, perform_id, detail
    if class_name.instance_of? String 
      class_object = class_name
    else
      class_object = class_name.class.name
    end
    Activity.create(activity_type: class_object, perform_id: perform_id, detail: detail)
  end

  def tracking_notification user_ids, activity_id
    params = []
    user_ids.each do |user_id|
      params << { user_id: user_id, activity_id: activity_id, mark_read: false }
    end
    AccountNotification.create(params)
  end
end
