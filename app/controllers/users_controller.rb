class UsersController < ApplicationController
  before_action :set_user, only: %i[chat]
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

  def profile 
    @user = current_user
  end

  def chat 

  end

  def update
    if current_user.update(user_params)
      redirect_to profile_path(current_user)
      # render_success("Update profile successfully")
    else
      render_danger(current_user.errors.full_messages.join(", "))
    end
  end

  private 

    def user_params 
      params.require(:user).permit(:full_name, :description, :avatar, social: {})
    end

    def set_user 
      @user = User.find(params[:id])
    end
end
