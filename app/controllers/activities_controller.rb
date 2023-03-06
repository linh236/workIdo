class ActivitiesController < ApplicationController
  before_action :set_activityable, only: [:create, :destroy]

  def create 
    @activity = Activity.new(activityable: @activityable, perform_id: current_user.id)
    if @activity.valid?
      @activity.save
    else
    end
  end

  def destroy
    Activity.where(activityable: @activityable, user: current_user).delete_all
  end

  private 

    def set_activityable
      @activityable = params[:activityable_type].constantize.find(params[:activityable_id])
    end
end
