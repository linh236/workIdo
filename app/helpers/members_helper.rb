module MembersHelper

  def status accept 
    return accept ? "Joined" : "Pending"
  end
end
