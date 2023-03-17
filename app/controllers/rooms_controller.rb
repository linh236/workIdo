class RoomsController < ApplicationController
  before_action :set_room, only: %i[show join_room leave_room]
  before_action :check_join_room, only: %i[show]
  def index
    @rooms = Room.public_room
    array = []

    current_user.rooms.private_room.each do |room|
      array << room
    end
    
    other_private_room = Room.private_room.where.not(user_id: current_user.id)
    other_private_room.each do |other|
      if other.joined
        array << other
      end
    end
    @private_rooms = array
    @users = User.all_except(current_user)
  end

  def show 
    @messages = @room.messages.order(created_at: :asc)
    @message = Message.new
    @users = User.all_except(current_user)
    @rooms = Room.public_room
    array = []

    current_user.rooms.private_room.each do |room|
      array << room
    end
    
    other_private_room = Room.private_room.where.not(user_id: current_user.id)
    other_private_room.each do |other|
      if other.joined
        array << other
      end
    end
    @private_rooms = array
    mark_read
  end

  def create 
    @room = Room.new(room_params)
    @room.user = current_user
    @room.member_ids << current_user.id
    if @room.save
      flash[:success] = "Created #{@room.name} successfully."
      redirect_to room_path(@room)
    else
    end
  end

  def join_room 
    @room.member_ids << current_user.id
    if @room.save
      # flash[:success] = "You joined #{@room.name} successfully."
      redirect_to rooms_path
    else
      # render_danger("You joined #{@room.name} failed.")
    end
  end
  
  def leave_room
    @room.member_ids.delete(current_user.id)
    if @room.save
      flash[:success] = "Leave #{@room.name} successfully."
      redirect_to rooms_path
    else
    end
  end

  def invite
    room = Room.find(params[:room_id])
    user = User.find(params[:user_id])
    invite_by = current_user
    time = DateTime.now.to_i
    InviteRoomMailer.invite(room, user, invite_by, time).deliver_now
    render_success("Sent a invite successfully to #{user.full_name} ")
  end

  def accept_invite
    current_time = DateTime.now.to_i
    time = params[:time].to_i
    if current_time - time <= 180
      room = Room.find(params[:room_id])
      user = User.find(params[:user_id])
      room.member_ids << user.id 
      if room.update(member_ids: room.member_ids)
        flash[:success] = "Joined successfully."
        redirect_to room_path(room)
      else
        flash[:danger] = room.erorrs.full_messages.join(", ")
        redirect_to rooms_path
      end
    else
      flash[:danger] = "Your invitation has expired."
      redirect_to rooms_path
    end
  end

  private

    def set_room 
      @room = Room.find(params[:id])
    end

    def room_params 
      params.require(:room).permit(:name, :is_private)
    end

    def mark_read
      @room.messages.each do |mes|
        mes.mark_read << current_user.id
        if mes.update(mark_read: mes.mark_read)

        else
          
        end
      end
    end

    def check_join_room
      if @room.is_private && current_user != @room.user && !@room.joined
        # render_danger("Do not have permission to access this group")
        flash[:danger] = "Do not have permission to access this group"
        redirect_to rooms_path
      end
    end
end
