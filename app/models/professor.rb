class Professor < ActiveRecord::Base
  belongs_to :department
  has_many :professor_scores
  has_many :course_scores
  validates :utln, uniqueness: true

  def get_score
    Evaluation.get_score_for_professor(self.id)
  end

  def get_score_for_course(course_id)
    puts course_id, self.id
    Evaluation.get_score_for_professor_and_course(self.id, course_id)
  end
end
