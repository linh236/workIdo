class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]

  def index 
  end

  def new 
    @project = Project.new
  end

  def show
    actived_project = ActiveProject.where(user: current_user).first
    if actived_project.present? 
      users_project = ActiveProject.where(user: current_user)
      users_project.update_all(active: false)
      active_project = ActiveProject.where(project: @project, user: current_user).first rescue nil
      if active_project.present? && active_project.update(active: true)
      else
        redirect_to project_path(@current_project)
      end
    else 
      if actived_project.present?
        actived_project.update(active: true)
      end
      redirect_to root_path
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
      params.require(:project).permit(:name, :description)
    end

    def set_project 
      @project = Project.find(params[:id])
    end
end
