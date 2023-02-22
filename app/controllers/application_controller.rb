class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_current_user, :projects, :current_project



  def projects 
    @projects ||= Project.owner.all.order(created_at: :desc) rescue nil
  end

  def current_project
    @current_project ||= Project.is_selected_project rescue nil
  end

  def set_current_user
    Current.user = current_user
  end
end
