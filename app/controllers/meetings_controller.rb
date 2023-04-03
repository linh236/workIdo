class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[show]
  def index
    start_date = params.fetch(:start_date, Date.today).to_date
    @meetings = Meeting.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
    @meetings = @meetings.select{|item| item.tags}
  end

  def show
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.user = current_user
    @meeting.project = @current_project
    @meeting.member_ids = Member.where(project_id: params[:meeting][:share_with]).pluck(:user_id)
    @meeting.member_ids << current_user.id
    @meeting.is_private = true if params[:meeting][:share_with] == "0"

    if @meeting.save
      redirect_to meetings_path, notice: "Create Event successfully"
    else
      redirect_to meetings_path, alert: @meeting.errors.full_meesage.join(", ")
    end
  end

  def update
  end

  def destroy
  end

  private
    
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end 

    def meeting_params 
      params.require(:meeting).permit(:name, :description, :start_time, :end_time, :level)
    end
end
