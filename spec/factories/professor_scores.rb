# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :professor_score do
    association :professor
    course_id 1
    semester_id 1
    department_id 1
    score "10"
    total_reviews 10
  end
end
