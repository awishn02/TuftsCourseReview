json.array!(@courses) do |course|
  json.extract! course, :id, :department_id, :course_num, :name, :school_id
  json.url course_url(course, format: :json)
end
