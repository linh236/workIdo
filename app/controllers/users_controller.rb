class UsersController < ApplicationController
  def list_users
    member_user_ids = Member.where(project: @current_project).pluck(:user_id) rescue []
    @users = User.search(params[:name]).where.not(id: member_user_ids) rescue []
    render turbo_stream: turbo_stream.replace(
      'users',
      partial: 'list',
      locals: {
        users: @users
      }
    )
  end
end
