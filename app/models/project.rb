class Project < ApplicationRecord

  before_create :update_selected
  after_create :selected_project, :default_label
  validates :name, presence: true, uniqueness: true

  has_many :labels
  
  scope :is_selected_project, -> { find_by(selected: true) }
  scope :owner, -> { where(user_id: Current.user.id)}

  def selected_project
    self.update(selected: true)

  end
  
  def default_label
    default_labels = [
      { name: 'TO DO', project_id: self.id },
      { name: 'PROCESS', project_id: self.id },
      { name: 'DONE', project_id: self.id },
    ]
    Label.create(default_labels)
  end

  def update_selected
    Project.update_all(selected: false)
  end
end
