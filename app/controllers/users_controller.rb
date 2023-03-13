class UsersController < ApplicationController
  before_action :set_user, only: %i[show update]
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

  def show 

  end

end
