class ActivityType::MoveTask < Activity
  # belongs_to :activity
  
  attr_accessor :id, :perform_id, :detail

  def self.call args = {}
    move_task_params(args)
    hash_params()
  end

  private 

    def self.move_task_params args
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
      from_label = Label.find(@detail["from_label_id"])      
      to_label = Label.find(@detail["to_label_id"])   
      
      "#{full_name} moved task #{task.name} from #{from_label.name} to #{to_label.name}"
    end

end
