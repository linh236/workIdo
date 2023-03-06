class TasksController < ApplicationController
  before_action :label, only: [:new, :create, :update, :show]
  before_action :set_task, only: [:show]

  def index
  end
  
  def show
    
  end
  def new
    @task = Task.new
  end

  def create 
    @task = Task.new(task_params)
    @task.label = @label
    @task.user = current_user
    if @task.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def move_task
    @task = Task.find_by_id(params[:id])
    
    if @task.present? && params[:label_id].present? 
      @start_move_label = params[:start_move_label]
      @task.reload
      if @task.update_columns(label_id: params[:label_id].to_i)
        activity = tracking_activity("ActivityType::MoveTask", {task_id: @task.id, from_label_id: @start_move_label.to_i, to_label_id: params[:label_id].to_i, project_id: Current.project.id})
        user_ids = @task.project.members.pluck(:user_id)
        tracking_notification(user_ids, activity.id) if user_ids.present?
      else
        p @task.errors
      end
    else

    end
  end

  def move_task_inside
    @from = Task.find(params[:from])
    @to = Task.find(params[:to])
    if @from.nil? || @to.nil?
      redirect_to root_path
    end
    from_priority = @from.priority
    to_priority = @to.priority
    @from.update(priority: to_priority)
    @to.update(priority: from_priority)

    # Tracking Move task 
    # tracking_activity("ActivityType::MoveTaskInside", detail: {from_task_id: @from.id, to_task_id: @to.id})
  end


  private

    def task_params 
      params.require(:task).permit(:name, :description, :level)
    end

    def label 
      @label = Label.find(params[:label_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end
end
