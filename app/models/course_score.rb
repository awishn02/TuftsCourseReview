class CourseScore < ActiveRecord::Base
  belongs_to :professor_score
  belongs_to :course_score
  validates_uniqueness_of :course_id, :scope => [:professor_id, :semester_id]
end
