class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit destroy update]
  before_action :set_task, only: %i[create show edit destroy update]
  
  def show
    
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.task_id = params[:task_id].to_i
    
    if @comment.save
      users_tag(comment_params[:description], params[:task_id].to_i)
      # redirect_to root_path
    else
      render_danger(@comment.errors.full_messages.join(", "))
    end
  end
  
  def update
    if @comment.update(comment_params)
    else
    end
  end

  def destroy
    @comment.destroy
  end
  
  private

    def set_comment 
      @comment = Comment.find(params[:id])
    end

    def set_task 
      @task = Task.find(params[:task_id])
    end
    
    def comment_params 
      params.require(:comment).permit(:description)
    end

    def users_tag comment_text, task_id
      user_ids = []
      comment_text.scan(/@\b[^@][a-z0-9]*\b/).each do |u|
        full_name = u.gsub("@", "") 
        user_ids << User.find_by_full_name(full_name).id
      end
      activity = tracking_activity("ActivityType::CommentTag", {task_id: task_id, tag_by: current_user.id, text: "Comment tag user"})
      tracking_notification(user_ids, activity.id)
    end
end
