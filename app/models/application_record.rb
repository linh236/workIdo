class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :asc_priority, -> { order(priority: :asc) }

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
      params << { user_id: user_id, activity_id: activity_id, read: false }
    end
    AccountNotification.create(params)
  end
end
