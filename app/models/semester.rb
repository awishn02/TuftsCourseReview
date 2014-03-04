class Semester < ActiveRecord::Base
  has_many :evaluations
  validates :name, uniqueness: true
end
