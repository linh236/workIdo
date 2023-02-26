class Task < ApplicationRecord
  acts_as_paranoid #soft detete
  belongs_to :user
  belongs_to :label
  validates :name, presence: true, uniqueness: { scope: :user_id }
  belongs_to :assign, class_name: "User", foreign_key: "assign_id", optional: true

  enum levels: [:highest, :high, :medium, :low]
  has_rich_text :description
  
  after_create :update_priority

  private 

    def update_priority
      self.update(priority: self.id)
    end
end
