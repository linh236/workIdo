class ActivityType::CommentTag < Activity 
  attr_accessor :id, :perform_id, :detail

  def self.call args = {}
    comment_task_params(args)
    hash_params()
  end

  private 

    def self.comment_task_params args
      @id = args["id"]
      @perform_id = args["perform_id"]
      @detail = args["detail"]
    end

    def self.hash_params
      hash = Hash.new
      hash[:label] = label
    end

    def self.label 
      full_name = @perform_id == Current.user.id ? "You" : User.find(@perform_id).full_name
      task = Task.find(@detail["task_id"])
      
      "#{full_name} tag you at #{task.name}"
    end
end