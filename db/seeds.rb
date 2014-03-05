# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
first = true
i = 0
CSV.foreach("#{Rails.root}/student_evals_scrambled.csv") do |row|
  if first
    first = false
  else
    dep = Department.create(
      :name => row[1],
      :dep_code => row[2].split('-')[0]
    )
    if !dep.id
      dep = Department.find_by_name(row[1])
    end
    school = School.create(
      :name => row[7].split(' - ')[1]
    )
    if !school.id
      school = School.find_by_name(row[7].split(' - ')[1])
    end
    semester = Semester.create(
      :name => row[7][/(\s*\S+){2}/]
    )
    if !semester.id
      semester = Semester.find_by_name(row[7][/(\s*\S+){2}/])
    end
    course = Course.create(
      :name => row[3],
      :department_id => dep.id,
      :school_id => school.id,
      :course_num => row[2]
    )
    if !course.id
      course = Course.find_by_name(row[3])
    end
    prof_name = row[4].split(',')
    professor = Professor.create(
      :name => prof_name[1] + " " + prof_name[0],
      :department_id => dep.id
    )
    if !professor.id
      professor = Professor.find_by_name(prof_name[1] + " " + prof_name[0])
    end
    evaluation = Evaluation.create(
      :course_id => course.id,
      :professor_id => professor.id,
      :semester_id => semester.id,
      :course_score => row[12],
      :teacher_score => row[9][0],
      :total_reviews => 1
    )
    if !evaluation.id
      evaluation = Evaluation.find_by_course_id_and_professor_id_and_semester_id(course.id, professor.id, semester.id)
      evaluation.course_score = (evaluation.course_score * evaluation.total_reviews + row[12].to_f) / (evaluation.total_reviews + 1)
      evaluation.teacher_score = (evaluation.teacher_score * evaluation.total_reviews + row[9][0].to_f) / (evaluation.total_reviews + 1)
      evaluation.total_reviews += 1
      evaluation.save
    end
  end
end
