class Evaluation < ActiveRecord::Base
  belongs_to :professor
  belongs_to :course
  belongs_to :semester
  validates_uniqueness_of :course_id, :scope => [:professor_id, :semester_id]


  def self.search(search)
    if search && search != ""
      where('upper(courses.name) LIKE upper(?) OR upper(professors.name)' +
            ' LIKE upper(?) OR upper(courses.course_num) LIKE upper(?)',
            "%#{search}%", "%#{search}%", "%#{search}%")
    else
      where('1=0')
    end
  end

  def get_professor_data
    Evaluation.select("AVG(evaluations.course_score) as average_course_score,"+
                      "AVG(evaluations.teacher_score) as average_teacher_score,"+
                      "evaluations.course_id AS course_id, courses.course_num AS "+
                      "course_num, courses.name, evaluations.professor_id AS professor_id,"+
                      "professors.name")
              .group(['course_id','course_num','courses.name','professor_id','professors.name'])
              .where('course_id = ?', self.course_id)
              .joins(:course,:semester,:professor)
              .order("course_num asc")
              .paginate(:per_page => 20, :page => 1)
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
