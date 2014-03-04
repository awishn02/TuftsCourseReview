class ChangePrecision < ActiveRecord::Migration
  def change
    change_column :evaluations, :course_score, :decimal, precision: 5, scale: 2
    change_column :evaluations, :teacher_score, :decimal, precision: 5, scale: 2
  end
end
