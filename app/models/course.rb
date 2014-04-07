class Course < ActiveRecord::Base
  belongs_to :department
  belongs_to :school
  has_many :professor_scores
  has_many :course_scores
  has_many :evaluations
  has_many :professors, through: :evaluations
  validates :course_num, uniqueness: true

  def get_score
    Evaluation.get_score_for_course(self.id)
  end

  def get_score_for_professor(prof_id)
    Evaluation.get_score_for_course_and_professor(self.id,prof_id)
  end
end
