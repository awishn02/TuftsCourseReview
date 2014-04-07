class ProfessorScore < ActiveRecord::Base
  belongs_to :professor
  belongs_to :course
  belongs_to :semester
  validates_uniqueness_of :course_id, :scope => [:professor_id, :semester_id]

  def self.search(search)
    if search && search != ""
      select("AVG(professor_scores.score) as average_professor_score,"+
             "AVG(course_scores.score) as average_course_score,"+
             "professor_scores.professor_id, professors.utln")
      .group(['professor_scores.professor_id', 'professors.utln'])
      .where('upper(courses.name) LIKE upper(?) OR upper(professors.name)' +
             ' LIKE upper(?) OR upper(courses.course_num) LIKE upper(?)',
             "%#{search}%", "%#{search}%", "%#{search}%")
      .joins("INNER JOIN course_scores ON professor_scores.professor_id "+
             "= course_scores.professor_id and professor_scores.course_id "+
             "= course_scores.course_id and professor_scores.semester_id ="+
             " course_scores.semester_id")
      .joins(:professor,:course,:semester)
    else
      where('1=0')
      .joins("INNER JOIN course_scores ON professor_scores.professor_id "+
             "= course_scores.professor_id and professor_scores.course_id "+
             "= course_scores.course_id and professor_scores.semester_id ="+
             " course_scores.semester_id")
      .joins(:professor,:course,:semester)
    end
  end

  def self.search_course(search)
    if search && search != ""
      select("AVG(professor_scores.score) as average_professor_score,"+
             "AVG(course_scores.score) as average_course_score,"+
             "professor_scores.course_id, courses.course_num,"+
             " courses.name")
      .group(['professor_scores.course_id', 'courses.course_num','courses.name'])
      .where('upper(courses.name) LIKE upper(?) OR upper(professors.name)' +
             ' LIKE upper(?) OR upper(courses.course_num) LIKE upper(?)',
             "%#{search}%", "%#{search}%", "%#{search}%")
      .joins("INNER JOIN course_scores ON professor_scores.professor_id "+
             "= course_scores.professor_id and professor_scores.course_id "+
             "= course_scores.course_id and professor_scores.semester_id ="+
             " course_scores.semester_id")
      .joins(:professor,:course,:semester)
    else
      where('1=0')
      .joins("INNER JOIN course_scores ON professor_scores.professor_id "+
             "= course_scores.professor_id and professor_scores.course_id "+
             "= course_scores.course_id and professor_scores.semester_id ="+
             " course_scores.semester_id")
      .joins(:professor,:course,:semester)
    end
  end

  def get_professor_data
    ProfessorScore.select("AVG(professor_scores.score) as average_professor_score,"+
                          "AVG(course_scores.score) as average_course_score,"+
                          "professor_scores.course_id, courses.course_num,"+
                          " courses.name, professor_scores.professor_id,"+
                          " professors.utln")
    .group(['professor_scores.course_id', 'courses.course_num','courses.name', 'professor_scores.professor_id', 'professors.utln'])
    .where('professor_scores.course_id = ?', self.course_id)
    .joins("INNER JOIN course_scores ON professor_scores.professor_id "+
           "= course_scores.professor_id and professor_scores.course_id "+
           "= course_scores.course_id and professor_scores.semester_id ="+
           " course_scores.semester_id")
    .joins(:professor,:course,:semester)
  end

  def get_semester_data
    ProfessorScore.select("AVG(professor_scores.score) as average_professor_score,"+
                          "AVG(course_scores.score) as average_course_score,"+
                          "professor_scores.course_id,professor_scores.semester_id,"+
                          " professor_scores.professor_id")
    .group(['professor_scores.course_id',  'professor_scores.professor_id', 'professor_scores.semester_id'])
    .where('professor_scores.professor_id = ? AND professor_scores.course_id = ?', self.professor_id, self.course_id)
    .joins("INNER JOIN course_scores ON professor_scores.professor_id "+
           "= course_scores.professor_id and professor_scores.course_id "+
           "= course_scores.course_id and professor_scores.semester_id ="+
           " course_scores.semester_id")
    .joins(:professor,:course,:semester)
  end

  def get_course_data
    ProfessorScore.select("AVG(professor_scores.score) as average_professor_score,"+
                          "AVG(course_scores.score) as average_course_score,"+
                          "professor_scores.course_id, courses.course_num,"+
                          " courses.name, professor_scores.professor_id,"+
                          " professors.utln")
    .group(['professor_scores.course_id', 'courses.course_num','courses.name', 'professor_scores.professor_id', 'professors.utln'])
    .where('professor_scores.professor_id = ?', self.professor_id)
    .joins("INNER JOIN course_scores ON professor_scores.professor_id "+
           "= course_scores.professor_id and professor_scores.course_id "+
           "= course_scores.course_id and professor_scores.semester_id ="+
           " course_scores.semester_id")
    .joins(:professor,:course,:semester)
  end
end
