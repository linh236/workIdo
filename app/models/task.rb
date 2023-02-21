class Task < ApplicationRecord
  belongs_to :user
  belongs_to :label
  validates :name, presence: true, uniqueness: true
  belongs_to :assign, class_name: "User", foreign_key: "assign_id", optional: true

  enum levels: [:highest, :high, :medium, :low]
  has_rich_text :description
  
  scope :asc_priority, -> { order(priority: :asc) }

  after_create :update_priority

  private 

    def update_priority
      self.update(priority: self.id)
    end
end
