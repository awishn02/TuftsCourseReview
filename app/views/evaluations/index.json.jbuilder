json.array!(@evaluations) do |evaluation|
  json.extract! evaluation, :id, :course_id, :teacher_id, :course_score, :teacher_score
  json.url evaluation_url(evaluation, format: :json)
end
