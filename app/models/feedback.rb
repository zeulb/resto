class Feedback < ApplicationRecord
  belongs_to :ratable, polymorphic: true

  validates_presence_of :rating
  validates :rating, inclusion: { in: [-1, 1] }
end
