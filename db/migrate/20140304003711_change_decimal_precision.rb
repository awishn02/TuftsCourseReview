class ChangeDecimalPrecision < ActiveRecord::Migration
  def change
    change_column :evaluations, :course_score, :decimal, :precision => 2
    change_column :evaluations, :teacher_score, :decimal, :precision => 2
  end
end
