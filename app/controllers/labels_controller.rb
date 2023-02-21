class LabelsController < ApplicationController
  before_action :project, only: [:create, :update]
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

  private

    def label_params
      params.require(:label).permit(:name)
    end

    def project 
      @project = Project.find(params[:project_id])
    end
end
