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
    Evaluation.create(
      :course_id => course.id,
      :professor_id => professor.id,
      :course_score => row[12],
      :teacher_score => row[9][0]
    )
  end
end
