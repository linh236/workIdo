class MessagesController < ApplicationController

  before_action :set_room, only: %i[create]
  def index
  end

  def new
    @message = Message.new  
  end

  def create
    @message = current_user.messages.new(message_params)
    @message.room = @room

    if @message.save
    else
    end
    
  end

  private 

    def set_message 
      @message = Message.find(params[:id])
    end

    def set_room
      @room = Room.find(params[:room_id])
    end

    def message_params 
      params.require(:message).permit(:body)
    end
end
