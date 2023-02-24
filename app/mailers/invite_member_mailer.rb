class InviteMemberMailer < ApplicationMailer
  def invite_member member, project
    @member = member
    @inviter = @member.inviter
    @user = @member.user
    @project = project
    mail to: @user.email, subject: "#{@inviter.full_name} Invited to join #{@project.name}"
  end
end
