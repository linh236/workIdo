class Message < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :user
  belongs_to :room

  after_create_commit do 
    broadcast_append_to(dom_id(room), partial: "messages/message", locals: { message: self }, target: "messages")
    broadcast_update_to("message-room-#{self.room_id}", partial: "messages/count_message", locals: { count_mess: self.room.messages.map{|e| e.count_message if e.count_message }.compact.size }, target: "room-#{self.room_id}")
  end

  def count_message 
    if self.mark_read.present? && self.mark_read.include?(Current.user.id)
      return false
    else
      return true
    end
  end

  private 


end
