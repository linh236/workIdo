class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :asc_priority, -> { order(priority: :asc) }

end
