class CourseScore < ActiveRecord::Base
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
    CourseScore.select("AVG(professor_scores.score) as average_professor_score,"+
                          "AVG(course_scores.score) as average_course_score,"+
                          "course_scores.course_id, courses.course_num,"+
                          " courses.name, course_scores.professor_id,"+
                          " professors.utln")
    .group(['course_scores.course_id', 'courses.course_num','courses.name', 'course_scores.professor_id', 'professors.utln'])
    .where('course_scores.course_id = ?', self.course_id)
    .joins("INNER JOIN professor_scores ON professor_scores.professor_id "+
           "= course_scores.professor_id and professor_scores.course_id "+
           "= course_scores.course_id and professor_scores.semester_id ="+
           " course_scores.semester_id")
    .joins(:professor,:course,:semester)
  end

  def get_semester_data
    CourseScore.select("AVG(professor_scores.score) as average_professor_score,"+
                          "AVG(course_scores.score) as average_course_score,"+
                          "course_scores.course_id,course_scores.semester_id,"+
                          " course_scores.professor_id")
    .group(['course_scores.course_id',  'course_scores.professor_id', 'course_scores.semester_id'])
    .where('course_scores.professor_id = ? AND course_scores.course_id = ?', self.professor_id, self.course_id)
    .joins("INNER JOIN professor_scores ON professor_scores.professor_id "+
           "= course_scores.professor_id and professor_scores.course_id "+
           "= course_scores.course_id and professor_scores.semester_id ="+
           " course_scores.semester_id")
    .joins(:professor,:course,:semester)
  end

  def get_course_data
    CourseScore.select("AVG(professor_scores.score) as average_professor_score,"+
                          "AVG(course_scores.score) as average_course_score,"+
                          "course_scores.course_id, courses.course_num,"+
                          " courses.name, course_scores.professor_id,"+
                          " professors.utln")
    .group(['course_scores.course_id', 'courses.course_num','courses.name', 'course_scores.professor_id', 'professors.utln'])
    .where('course_scores.professor_id = ?', self.professor_id)
    .joins("INNER JOIN professor_scores ON professor_scores.professor_id "+
           "= course_scores.professor_id and professor_scores.course_id "+
           "= course_scores.course_id and professor_scores.semester_id ="+
           " course_scores.semester_id")
    .joins(:professor,:course,:semester)
  end
end
