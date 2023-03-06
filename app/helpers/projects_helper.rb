module ProjectsHelper
  def is_manager project
    return project&.user_id == current_user&.id
  end
end
