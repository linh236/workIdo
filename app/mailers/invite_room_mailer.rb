class InviteRoomMailer < ApplicationMailer
  def invite room, user, invite_by, time
    @room = room
    @user = user
    @invite_by = invite_by
    @time = time
    mail to: @user.email, subject: "You have a invite to join #{@room.name} room"
  end
end
