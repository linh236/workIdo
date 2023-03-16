class Task < ApplicationRecord
  include ActionView::RecordIdentifier

  acts_as_paranoid #soft detete
  belongs_to :user
  belongs_to :label
  validates :name, presence: true, uniqueness: { scope: :user_id }
  belongs_to :assign, class_name: "User", foreign_key: "assign_id", optional: true
  has_one :project, :through => :label
  has_many :comments, dependent: :destroy
  enum levels: [:highest, :high, :medium, :low]
  has_rich_text :description
  
  after_create :update_priority

  after_update_commit do
    broadcast_append_to("move-task", partial: "tasks/item_task", locals: { task: self, project: Current.project }, target: "label-#{self.label_id}")   
  end

  def assign_members
    Member.where(project_id: self.label.project_id)
  end

  private 

    def update_priority
      self.update(priority: self.id)
      tracking_activity(self, {task_id: self.id, text: "Create a new task #{self.name}", project_id: Current.project.id})
    end
end
