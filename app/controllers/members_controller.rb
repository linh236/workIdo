class MembersController < ApplicationController
  before_action :project, only: [:invite_member, :accept_join]
  before_action :set_member, only: [:accept_join, :remove_member]
  def index 
    @members = Member.all
  end

  def new 
    @member = Member.new
  end

  def invite_member 
    @member = Member.new
    @member.user_id = params[:user_id]
    @member.invited_by = current_user.id
    @member.project = @project
    if @member.save
      InviteMemberMailer.invite_member(@member, @project).deliver_now
      render_success("Invited successfully.")
      # redirect_to project_members_path(@project)
      else
      render_danger(@member.errors.full_messages.join(", "))
    end
  end

  def accept_join 
    if @project.present? && @member.present?
      @member.update(accept: true)
      ActiveProject.create(project: @project, user: current_user, active: false)
      redirect_to root_path
    else
      render_danger(@member.errors.full_messages.join(", "))
    end
  end

  def remove_member

  end

  private 
    
    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(:user_id, :project_id, :accept, :invited_by)
    end

    def project 
      @project = Project.find(params[:project_id])
    end
end
