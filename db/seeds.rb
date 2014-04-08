# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
DEP_NAME = 1
DEP_CODE = 2
SCHOOL_NAME = 7
SEMESTER_NAME = 7
COURSE_NAME = 3
COURSE_NUM = 2
PROFESSOR_NAME = 4
PROFESSOR_UTLN = 9
QUESTION = 8
SCORE = 12

first = true
i = 0
CSV.foreach("#{Rails.root}/student_evals_scrambled.csv") do |row|
  if first
    first = false
  else
    dep = Department.create(
      :name => row[DEP_NAME],
      :dep_code => row[DEP_CODE].split('-')[0],
      :opt_out => false
    )
    if !dep.id
      dep = Department.find_by_name(row[DEP_NAME])
    end
    school = School.create(
      :name => row[SCHOOL_NAME].split(' - ')[1]
    )
    if !school.id
      school = School.find_by_name(row[SCHOOL_NAME].split(' - ')[1])
    end
    semester = Semester.create(
      :name => row[SEMESTER_NAME][/(\s*\S+){2}/]
    )
    if !semester.id
      semester = Semester.find_by_name(row[SEMESTER_NAME][/(\s*\S+){2}/])
    end
    course = Course.create(
      :name => row[COURSE_NAME],
      :department_id => dep.id,
      :school_id => school.id,
      :course_num => row[COURSE_NUM]
    )
    if !course.id
      course = Course.find_by_course_num(row[COURSE_NUM])
    end
    prof_name = "N/A"
    if row[PROFESSOR_NAME]
      prof_name = row[PROFESSOR_NAME].split(',')
    end
    professor = Professor.create(
      :name => prof_name[1] + " " + prof_name[0],
      :department_id => dep.id,
      :utln => row[PROFESSOR_UTLN],
      :opt_out => false
    )
    if !professor.id
      professor = Professor.find_by_utln(row[PROFESSOR_UTLN])
    end
    if row[QUESTION].include? "instructor"
      p = ProfessorScore.create(
        :professor_id => professor.id,
        :course_id => course.id,
        :semester_id => semester.id,
        :department_id => dep.id,
        :score => row[SCORE],
        :total_reviews => 1
      )
      if !p.id
        p = ProfessorScore.find_by_course_id_and_professor_id_and_semester_id(course.id, professor.id, semester.id)
        p.score = (p.score * p.total_reviews + row[SCORE].to_f) / (p.total_reviews + 1)
        p.total_reviews += 1
        p.save
      end
    else
      c = CourseScore.create(
        :professor_id => professor.id,
        :course_id => course.id,
        :semester_id => semester.id,
        :department_id => dep.id,
        :score => row[SCORE],
        :total_reviews => 1
      )

      if !c.id
        c = CourseScore.find_by_course_id_and_professor_id_and_semester_id(course.id, professor.id, semester.id)
        c.score = (c.score * c.total_reviews + row[SCORE].to_f) / (c.total_reviews + 1)
        c.total_reviews += 1
        c.save
      end
    end
  end
  i += 1
end
puts i
