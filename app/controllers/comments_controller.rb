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
end
