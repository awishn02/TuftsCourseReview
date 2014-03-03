class Department < ActiveRecord::Base
  has_many :professors
  has_many :courses
  validates :name, uniqueness: true
end
