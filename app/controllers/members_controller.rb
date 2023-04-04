class MembersController < ApplicationController
  before_action :project, only: [:invite_member, :accept_join, :remove_member]
  before_action :set_member, only: [:accept_join]
  before_action :user, only: [:remove_member]

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
      add_or_remove_calendar("add", @project, current_user)
      redirect_to root_path
    else
      render_danger(@member.errors.full_messages.join(", "))
    end
  end

  def remove_member
    active_project = ActiveProject.where(user: @user, project: @project).first
    if active_project.present?
      if active_project.active 
        active_project.destroy
        set_active_project = ActiveProject.where(user: @user).first
        add_or_remove_calendar("remove", @project, @user)
        if set_active_project.present?
          set_active_project.update(active: true)
        end
      else
        active_project.destroy
      end
    end
    member = Member.where(user: @user, project: @project).first
    member.destroy
    redirect_to project_path(@project)
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

    def user 
      @user = User.find(params[:user_id])
    end

    def add_or_remove_calendar type, project, user
      meetings = Meeting.where(project_id: project.id, is_private: false)
      meetings.each do |meeting|
        if type == "add"
          meeting.member_ids << user.id
        else
          meeting.member_ids.delete(user.id)
        end
        meeting.update(member_ids: meeting.member_ids)
      end
    end

end
