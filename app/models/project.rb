class Project < ApplicationRecord

  after_create :active_project
  validates :name, presence: true, uniqueness: { scope: :deleted_at }

  has_many :labels,  dependent: :destroy
  has_many :members,  dependent: :destroy
  has_many :active_projects, dependent: :destroy
  belongs_to :assign, class_name: "User", foreign_key: "assign_id", optional: true
  has_many :tasks, through: :label
  
  scope :is_selected_project, -> { find_by(selected: true) }
  scope :owner, -> { where(user_id: Current.user.id)}

  has_many :activities, class_name: "ActivityType::MoveTask", dependent: :destroy

  def active_project
    active_projects = ActiveProject.where(user: Current.user)
    active_projects.update_all(active: false)
    ActiveProject.create(user: Current.user, project: self, active: true)

    # Tracking activity 
    tracking_activity(self, {project_id: self.id, text: "Create a new project #{self.name}"})
  end
  
  def default_label
    default_labels = [
      { name: 'TO DO', project_id: self.id },
      { name: 'PROCESS', project_id: self.id },
      { name: 'DONE', project_id: self.id },
    ]
    Label.create(default_labels)
  end
end
 