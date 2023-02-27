module ProjectsHelper
  def is_manager
    return @current_project.user_id == current_user&.id
  end
end
