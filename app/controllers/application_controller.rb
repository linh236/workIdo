class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_current_user, :projects, :current_project



  def projects 
    @projects ||= ActiveProject.user_project
  end

  def current_project
    active_project = ActiveProject.where(user: current_user, active: true).first
    @current_project = active_project.project rescue nil
  end

  def set_current_user
    Current.user = current_user
    Current.project = current_project
  end

  def render_success message
    render turbo_stream: turbo_stream.append(
      'toast',
      partial: 'shared/toast_success',
      locals: {
        message: message
      }
    )
  end

  def render_danger message
    render turbo_stream: turbo_stream.append(
      'toast',
      partial: 'shared/toast_danger',
      locals: {
        message: message
      }
    )
  end

  def render_warning message
    render turbo_stream: turbo_stream.append(
      'toast',
      partial: 'shared/toast_warning',
      locals: {
        message: message
      }
    )
  end

end
