class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]

  def index 
  end

  def new 
    @project = Project.new
  end

  def show
    Project.update_all(selected: false)
    @project.reload
    if @project.selected_project
    else
    end
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    if @project.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end
  
  def destroy
  end

  private

    def project_params
      params.require(:project).permit(:name, :description, :selected)
    end

    def set_project 
      @project = Project.find(params[:id])
    end
end
