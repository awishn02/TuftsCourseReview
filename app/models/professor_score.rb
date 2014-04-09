class ProfessorScore < ActiveRecord::Base
  belongs_to :professor
  belongs_to :course
  belongs_to :semester
  belongs_to :department
  validates_uniqueness_of :course_id, :scope => [:professor_id, :semester_id]
  after_save :expire_cache
  after_destroy :expire_cache

  def self.search(search)
    if search && search != ""
      select("AVG(professor_scores.score) as average_professor_score,"+
             "AVG(course_scores.score) as average_course_score,"+
             "professor_scores.professor_id, professors.utln,"+
             "professors.name as professor_name")
      .group(['professor_scores.professor_id', 'professors.utln','professors.name'])
      .where('(upper(courses.name) LIKE upper(?) OR upper(professors.name)' +
             ' LIKE upper(?) OR upper(courses.course_num) LIKE upper(?))' +
             ' and (professors.opt_out = false and departments.opt_out = false)',
             "%#{search}%", "%#{search}%", "%#{search}%")
      .joins("INNER JOIN course_scores ON professor_scores.professor_id "+
             "= course_scores.professor_id and professor_scores.course_id "+
             "= course_scores.course_id and professor_scores.semester_id ="+
             " course_scores.semester_id")
      .joins(:professor,:course,:semester,:department)
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
             "professor_scores.course_id, courses.course_num as course_num,"+
             " courses.name as course_name")
      .group(['professor_scores.course_id', 'courses.course_num','courses.name'])
      .where('(upper(courses.name) LIKE upper(?) OR upper(professors.name)' +
             ' LIKE upper(?) OR upper(courses.course_num) LIKE upper(?))' +
             ' and (professors.opt_out = false and departments.opt_out = false)',
             "%#{search}%", "%#{search}%", "%#{search}%")
      .joins("INNER JOIN course_scores ON professor_scores.professor_id "+
             "= course_scores.professor_id and professor_scores.course_id "+
             "= course_scores.course_id and professor_scores.semester_id ="+
             " course_scores.semester_id and professor_scores.department_id = "+
             " course_scores.department_id")
      .joins(:professor,:course,:semester,:department)
    else
      where('1=0')
      .joins("INNER JOIN course_scores ON professor_scores.professor_id "+
             "= course_scores.professor_id and professor_scores.course_id "+
             "= course_scores.course_id and professor_scores.semester_id ="+
             " course_scores.semester_id")
      .joins(:professor,:course,:semester)
    end
  end

  def self.get_professor_data(id)
    prof_data = Rails.cache.read(id.to_s + "profdata")
    if !prof_data
      prof_data = ProfessorScore.select("AVG(professor_scores.score) as average_professor_score,"+
                                        "AVG(course_scores.score) as average_course_score,"+
                                        "professor_scores.course_id, courses.course_num,"+
                                        " courses.name as course_name, professor_scores.professor_id,"+
                                        " professors.utln", "professors.name as professor_name")
      .group(['professor_scores.course_id', 'courses.course_num','courses.name', 'professor_scores.professor_id',
              'professors.utln', 'professors.name'])
      .where('professor_scores.course_id = ?', id)
      .joins("INNER JOIN course_scores ON professor_scores.professor_id "+
             "= course_scores.professor_id and professor_scores.course_id "+
             "= course_scores.course_id and professor_scores.semester_id ="+
             " course_scores.semester_id")
      .joins(:professor,:course,:semester)
      Rails.cache.write(id.to_s + "profdata", prof_data)
    end
    prof_data
  end

  def get_semester_data
    semester_data = Rails.cache.read(self.professor_id.to_s + "-" + self.course_id.to_s + "sem_data")
    if !semester_data
      semester_data = ProfessorScore.select("AVG(professor_scores.score) as average_professor_score,"+
                                            "AVG(course_scores.score) as average_course_score,"+
                                            "professor_scores.course_id,professor_scores.semester_id,"+
                                            " professor_scores.professor_id, semesters.name as semester_name")
      .group(['professor_scores.course_id',  'professor_scores.professor_id', 'professor_scores.semester_id','semesters.name'])
      .where('professor_scores.professor_id = ? AND professor_scores.course_id = ?', self.professor_id, self.course_id)
      .joins("INNER JOIN course_scores ON professor_scores.professor_id "+
             "= course_scores.professor_id and professor_scores.course_id "+
             "= course_scores.course_id and professor_scores.semester_id ="+
             " course_scores.semester_id")
      .joins(:professor,:course,:semester)
      Rails.cache.write(self.professor_id.to_s + "-" + self.course_id.to_s + "sem_data", semester_data)
    end
    semester_data
  end

  def self.get_course_data(id)
    course_data = Rails.cache.read(id.to_s + "coursedata")
    if !course_data
      course_data = ProfessorScore.select("AVG(professor_scores.score) as average_professor_score,"+
                                          "AVG(course_scores.score) as average_course_score,"+
                                          "professor_scores.course_id, courses.course_num,"+
                                          " courses.name as course_name, professor_scores.professor_id,"+
                                          " professors.utln, professors.name as professor_name")
      .group(['professor_scores.course_id', 'courses.course_num','courses.name', 'professor_scores.professor_id',
              'professors.utln', 'professors.name'])
      .where('professor_scores.professor_id = ?', id)
      .joins("INNER JOIN course_scores ON professor_scores.professor_id "+
             "= course_scores.professor_id and professor_scores.course_id "+
             "= course_scores.course_id and professor_scores.semester_id ="+
             " course_scores.semester_id")
      .joins(:professor,:course,:semester)
      Rails.cache.write(id.to_s + "coursedata", course_data)
    end
    course_data
  end

  def expire_cache
    Rails.cache.clear
  end

end
