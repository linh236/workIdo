class RoomsController < ApplicationController
  before_action :set_room, only: %i[show join_room]
  before_action :check_join_room, only: %i[show]
  def index
    @rooms = Room.public_room
    @private_rooms = current_user.rooms.private_room
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
