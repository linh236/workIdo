class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task
  has_rich_text :description

  validates :description, presence: true, length: { minimum: 10 }
end
