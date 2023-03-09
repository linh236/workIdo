class Task < ApplicationRecord
  acts_as_paranoid #soft detete
  belongs_to :user
  belongs_to :label
  validates :name, presence: true, uniqueness: { scope: :user_id }
  belongs_to :assign, class_name: "User", foreign_key: "assign_id", optional: true
  has_one :project, :through => :label

  enum levels: [:highest, :high, :medium, :low]
  has_rich_text :description
  
  after_create :update_priority

  def assign_members
    Member.where(project_id: self.label.project_id)
  end

  private 

    def update_priority
      self.update(priority: self.id)
      tracking_activity(self, {task_id: self.id, text: "Create a new task #{self.name}", project_id: Current.project.id})
    end
end
