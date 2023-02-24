class LabelsController < ApplicationController
  before_action :project, only: [:create, :update]
  before_action :set_label, only: [:destroy, :update]
  def index
  end
  
  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    @label.project = @project
    if @label.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @label.update(label_params)
      redirect_to project_path(@current_project)
    else
    end
  end

  def move_label
    @from = Label.find(params[:from])
    @to = Label.find(params[:to])
    from_priority = @from.priority
    to_priority = @to.priority
    @from.update(priority: to_priority)
    @to.update(priority: from_priority)
  end

  def destroy
    @label.destroy
  end

  private

    def label_params
      params.require(:label).permit(:name)
    end

    def project 
      @project = Project.find(params[:project_id])
    end

    def set_label
      @label = Label.find(params[:id])
    end
end
