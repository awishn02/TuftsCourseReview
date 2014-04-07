class CreateProfessorScores < ActiveRecord::Migration
  def change
    create_table :professor_scores do |t|
      t.integer :prof_id
      t.integer :course_id
      t.integer :semester_id
      t.decimal :score

      t.timestamps
    end
  end
end
