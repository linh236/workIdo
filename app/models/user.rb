class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tasks

  has_many :assign_tasks, class_name: "Task", foreign_key: "assign_id"
  has_many :members,  dependent: :destroy
  has_many :inviters, class_name: "Member", foreign_key: "invited_by", dependent: :destroy
  has_many :account_notifications, dependent: :destroy
  has_many :performers, class_name: "Activity", foreign_key: "perform_id", dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_one_attached :avatar
  has_rich_text :description
  has_many :messages
  has_many :rooms
  
  after_create :default_avatar 
  # validates :full_name, presence: true
  scope :all_except, ->(user) { where.not(id: user)}

  # after_create_commit do 
  #   broadcast_append_to "users"
  # end

  def self.search word
    if word.present?
      search_word = "%#{word}%"
      where("full_name LIKE ? OR email LIKE ?", search_word, search_word)
    else
      []
    end
  end

  def default_avatar
    self.full_name = self.email.split("@")[0]
    self.avatar.attach(io: File.open("#{Rails.root}/app/assets/images/avatar.png"), filename: "avatar.png")
    self.save
  end
end
