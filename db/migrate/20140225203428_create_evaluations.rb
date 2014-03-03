class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :course_id
      t.integer :teacher_id
      t.integer :course_score
      t.integer :teacher_score

      t.timestamps
    end
  end
end
