class ActivityType::AcceptInvite < Activity 
  attr_accessor :id, :perform_id, :detail

  def self.call args = {}
    accept_invite_params(args)
    hash_params()
  end

  private 

    def self.hash_params
      hash = Hash.new
      hash[:label] = label
    end

    def self.label 
      
    end
end