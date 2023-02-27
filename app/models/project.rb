class Project < ApplicationRecord

  after_create :active_project, :default_label
  validates :name, presence: true, uniqueness: { scope: :deleted_at }

  has_many :labels,  dependent: :destroy
  has_many :members,  dependent: :destroy
  has_many :active_projects, dependent: :destroy
  belongs_to :assign, class_name: "User", foreign_key: "assign_id", optional: true
  
  scope :is_selected_project, -> { find_by(selected: true) }
  scope :owner, -> { where(user_id: Current.user.id)}

  def active_project
    active_projects = ActiveProject.where(user: Current.user)
    active_projects.update_all(active: false)
    ActiveProject.create(user: Current.user, project: self, active: true)
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
 