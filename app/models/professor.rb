class Professor < ActiveRecord::Base
  belongs_to :department
  has_many :professor_scores
  has_many :course_scores
  validates :utln, uniqueness: true
  validates :name, :department_id, :utln, presence: true

  def get_score
    Evaluation.get_score_for_professor(self.id)
  end

  def get_score_for_course(course_id)
    puts course_id, self.id
    Evaluation.get_score_for_professor_and_course(self.id, course_id)
  end

  def self.search(search)
    if search && search != ""
      where('upper(name) LIKE upper(?) OR upper(utln) LIKE upper(?)',
             "%#{search}%", "%#{search}%")
    else
      all
    end
  end
end
