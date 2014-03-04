class ChangeScoreFormatInEvaluations < ActiveRecord::Migration
  def change
    change_column :evaluations, :course_score, :decimal
    change_column :evaluations, :teacher_score, :decimal
  end
end
