class Evaluation < ActiveRecord::Base
  belongs_to :professor
  belongs_to :course
  belongs_to :semester
  validates_uniqueness_of :course_id, :scope => [:professor_id, :semester_id]


  def self.search(search)
    if search && search != ""
      where('upper(courses.name) LIKE upper(?) OR upper(professors.name) LIKE upper(?) OR upper(courses.course_num) LIKE upper(?)', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      where('1=0')
    end
  end

  def self.get_score_for_professor(id)
    scores = Evaluation.find_all_by_professor_id(id)
    total_score = 0
    total = 0
    scores.each do |row|
      total_score += row.teacher_score
      total += 1
    end
    total_score.to_f/total
  end

  def self.get_score_for_professor_and_course(prof_id, course_id)
    scores = Evaluation.where(professor_id: prof_id, course_id: course_id).to_a
    total_score = 0
    total = 0
    scores.each do |row|
      total_score += row.teacher_score
      total += 1
    end
    total_score.to_f/total
  end

  def self.get_score_for_course(id)
    scores = Evaluation.find_all_by_course_id(id)
    total_score = 0
    total = 0
    scores.each do |row|
      total_score += row.course_score
      total += 1
    end
    total_score.to_f/total
  end

  def self.get_score_for_course_and_professor(course_id, prof_id)
    scores = Evaluation.where(professor_id: prof_id, course_id: course_id).to_a
    total_score = 0
    total = 0
    scores.each do |row|
      total_score += row.course_score
      total += 1
    end
    total_score.to_f/total
  end
end
