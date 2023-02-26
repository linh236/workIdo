class Label < ApplicationRecord
  acts_as_paranoid #soft detete
  belongs_to :project
  has_many :tasks,  dependent: :destroy
  validates :name, presence: true, uniqueness: true

  scope :default_label, ->(project) { where(project_id: project.id) }

  after_create :update_priority

  private

    def update_priority
      self.update(priority: self.id)
    end
end
