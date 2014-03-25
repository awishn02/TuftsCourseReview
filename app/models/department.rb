class Department < ActiveRecord::Base
  has_many :professors
  has_many :courses
  validates :name, uniqueness: true
  has_many :evaluations, through: :courses
end
