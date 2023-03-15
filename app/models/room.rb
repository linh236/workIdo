class Room < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  scope :public_room, -> {where(is_private: false)}
  scope :private_room, -> {where(is_private: true)}
  has_many :messages
  belongs_to :user

  # after_create_commit do 
  #   broadcast_append_to("rooms", partial: "rooms/room", target: "rooms")
  # end
  def joined 
    if self.member_ids.present? && self.member_ids.include?(Current.user.id)
      return true
    else
      return false
    end
  end
end
