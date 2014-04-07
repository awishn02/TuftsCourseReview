# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :professor_score do
    prof_id 1
    course_id 1
    semester_id 1
    score "9.99"
  end
end
