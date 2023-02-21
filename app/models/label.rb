class Label < ApplicationRecord
  belongs_to :project
  has_many :tasks
  validates :name, presence: true, uniqueness: true

  scope :default_label, ->(project) { where(project_id: project.id) }
end
