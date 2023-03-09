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

  has_one_attached :avatar
  
  after_create :default_avatar 

  def self.search word
    if word.present?
      search_word = "%#{word}%"
      where("full_name LIKE ? OR email LIKE ?", search_word, search_word)
    else
      []
    end
  end

  def default_avatar
    self.full_name = self.email
    self.avatar.attach(io: File.open("#{Rails.root}/app/assets/images/avatar.png"), filename: "avatar.png")
    self.save
  end
end
